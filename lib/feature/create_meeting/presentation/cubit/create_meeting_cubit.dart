import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:winmeet_mobile/app/constants/cache_contants.dart';
import 'package:winmeet_mobile/app/utils/calendar/calendar_utils.dart';
import 'package:winmeet_mobile/core/clients/cache/cache_client.dart';
import 'package:winmeet_mobile/feature/create_meeting/data/model/create_meeting_request_model.dart';
import 'package:winmeet_mobile/feature/create_meeting/data/repository/create_meeting_repository.dart';

part 'create_meeting_cubit.freezed.dart';
part 'create_meeting_state.dart';

@injectable
class CreateMeetingCubit extends Cubit<CreateMeetingState> {
  CreateMeetingCubit({required CreateMeetingRepository createMeetingRepository, required CacheClient cacheClient})
      : _createMeetingRepository = createMeetingRepository,
        _cacheClient = cacheClient,
        super(CreateMeetingState.initial());

  final CreateMeetingRepository _createMeetingRepository;
  final CacheClient _cacheClient;

  Future<void> createMeeting() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final token = _cacheClient.getString(CacheConstants.token);
    final jwt = Jwt.parseJwt(token!);

    final response = await _createMeetingRepository.createMeeting(
      createMeetingRequestModel: CreateMeetingRequestModel(
        eventOwner: jwt['email'] as String,
        eventName: state.title.value,
        eventDescription: state.description.value,
        location: state.location.value,
        eventStartDate: state.startDateTime.toIso8601String(),
        eventEndDate: state.endDateTime.toIso8601String(),
        eventStartDate2: state.startDateTime2 != null ? state.startDateTime2!.toIso8601String() : null,
        eventEndDate2: state.endDateTime2 != null ? state.endDateTime2!.toIso8601String() : null,
        eventStartDate3: state.startDateTime3 != null ? state.startDateTime3!.toIso8601String() : null,
        eventEndDate3: state.endDateTime3 != null ? state.endDateTime3!.toIso8601String() : null,
        participants: state.participants.value,
      ),
    );

    response.fold(
      (failure) => emit(state.copyWith(status: FormzStatus.submissionFailure)),
      (success) => emit(state.copyWith(status: FormzStatus.submissionSuccess)),
    );
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

  void setStartDateTime({required DateTime startDateTime, required int index}) {
    if (index == 0) {
      emit(state.copyWith(startDateTime: startDateTime));
    } else if (index == 1) {
      emit(state.copyWith(startDateTime2: startDateTime));
    } else {
      emit(state.copyWith(startDateTime3: startDateTime));
    }
  }

  void setEndDateTime({required DateTime endDateTime, required int index}) {
    if (index == 0) {
      emit(state.copyWith(endDateTime: endDateTime));
    } else if (index == 1) {
      emit(state.copyWith(endDateTime2: endDateTime));
    } else {
      emit(state.copyWith(endDateTime3: endDateTime));
    }
  }

  void setStartAndEndDateTime({required DateTime startDateTime, required DateTime endDateTime, required int index}) {
    if (index == 0) {
      emit(state.copyWith(startDateTime: startDateTime, endDateTime: endDateTime));
    } else if (index == 1) {
      emit(state.copyWith(startDateTime2: startDateTime, endDateTime2: endDateTime));
    } else {
      emit(state.copyWith(startDateTime3: startDateTime, endDateTime3: endDateTime));
    }
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
