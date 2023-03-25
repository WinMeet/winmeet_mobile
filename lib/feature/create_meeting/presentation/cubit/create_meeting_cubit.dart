import 'package:bloc/bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/utils/calendar/calendar_utils.dart';
import 'package:winmeet_mobile/feature/create_meeting/data/model/create_meeting_request_model.dart';
import 'package:winmeet_mobile/feature/create_meeting/data/repository/create_meeting_repository.dart';

part 'create_meeting_cubit.freezed.dart';
part 'create_meeting_state.dart';

@injectable
class CreateMeetingCubit extends Cubit<CreateMeetingState> {
  CreateMeetingCubit({required CreateMeetingRepository createMeetingRepository})
      : _createMeetingRepository = createMeetingRepository,
        super(CreateMeetingState.initial());

  final CreateMeetingRepository _createMeetingRepository;

  Future<void> createMeeting() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _createMeetingRepository.createMeeting(
        createMeetingRequestModel: CreateMeetingRequestModel(
          eventName: state.title.value,
          eventDescription: state.description.value,
          location: state.location.value,
          eventStartDate: state.startDateTime.toIso8601String(),
          eventEndDate: state.endDateTime.toIso8601String(),
          participants: state.participants.value,
        ),
      );
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void titleChanged({required String title}) {
    final newTitle = InputFormField.dirty(value: title);

    emit(
      state.copyWith(
        title: newTitle,
        status: Formz.validate([
          newTitle,
          state.description,
          state.location,
          state.participants,
          state.participants,
        ]),
      ),
    );
  }

  void descriptionChanged({required String description}) {
    final newDescription = InputFormField.dirty(value: description);

    emit(
      state.copyWith(
        description: newDescription,
        status: Formz.validate([
          newDescription,
          state.title,
          state.location,
          state.participants,
          state.participants,
        ]),
      ),
    );
  }

  void locationChanged({required String location}) {
    final newLocation = InputFormField.dirty(value: location);

    emit(
      state.copyWith(
        location: newLocation,
        status: Formz.validate([
          newLocation,
          state.title,
          state.description,
          state.participants,
          state.participants,
        ]),
      ),
    );
  }

  void setStartDateTime({required DateTime startDateTime}) {
    emit(state.copyWith(startDateTime: startDateTime));
  }

  void setEndDateTime({required DateTime endDateTime}) {
    emit(state.copyWith(endDateTime: endDateTime));
  }

  void setStartAndEndDateTime({required DateTime startDateTime, required DateTime endDateTime}) {
    emit(state.copyWith(startDateTime: startDateTime, endDateTime: endDateTime));
  }

  void emailChanged({required String email}) {
    final newEmail = EmailFormInput.dirty(email);
    emit(state.copyWith(email: newEmail, status: Formz.validate([newEmail])));
  }

  void resetAddParticipantsVariables() {
    emit(state.copyWith(email: const EmailFormInput.pure()));
  }

  bool addParticipantToParticipants({required String email}) {
    final participants = state.participants;
    if (!participants.value.contains(email)) {
      final newParticipants = <String>[email, ...participants.value];

      emit(
        state.copyWith(
          participants: ListFormInput<String>.dirty(newParticipants),
          status: Formz.validate([
            state.title,
            ListFormInput<String>.dirty(newParticipants),
            state.description,
            state.location,
          ]),
        ),
      );
      emit(
        state.copyWith(
          email: const EmailFormInput.pure(),
        ),
      );
      return true;
    }
    return false;
  }

  void removeParticipantFromParticipants({required String email}) {
    final participants = state.participants;
    final newParticipants = participants.value.where((participant) => participant != email).toList();

    emit(
      state.copyWith(
        participants: ListFormInput<String>.dirty(newParticipants),
        status: Formz.validate([
          state.title,
          ListFormInput<String>.dirty(newParticipants),
          state.description,
          state.location,
        ]),
      ),
    );
  }
}
