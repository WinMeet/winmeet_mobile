import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/feature/add_participants/data/repository/add_participants_repository.dart';

part 'add_participants_state.dart';
part 'add_participants_cubit.freezed.dart';

@injectable
class AddParticipantsCubit extends Cubit<AddParticipantsState> {
  AddParticipantsCubit({required AddParticipantsRepository addParticipantsRepository})
      : _addParticipantsRepository = addParticipantsRepository,
        super(AddParticipantsState.initial());

  final AddParticipantsRepository _addParticipantsRepository;

  ListFormInput<String> initialValues = ListFormInput.pure();
  void initializeParticipants({required ListFormInput<String> participants, required bool canRemoveParticipants}) {
    if (canRemoveParticipants) {
      emit(state.copyWith(participants: participants));
    } else {
      initialValues = participants;
      emit(state.copyWith(participants: participants));
    }
  }

  Future<void> updateMeetingParticipants({required String id, required List<String> participants}) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    final response = await _addParticipantsRepository.updateMeetingParticipants(
      id: id,
      participants: participants,
    );

    response.fold(
      (failure) => emit(state.copyWith(status: FormzStatus.submissionFailure)),
      (success) => emit(state.copyWith(status: FormzStatus.submissionSuccess)),
    );
  }

  void emailChanged({required String email}) {
    final newEmail = EmailFormInput.dirty(email);
    emit(state.copyWith(email: newEmail));
  }

  bool canBeRemoved({required String email}) {
    if (initialValues.value.contains(email)) {
      return false;
    } else {
      return true;
    }
  }

  bool addParticipantToParticipants({required String email}) {
    final participants = state.participants;
    if (!participants.value.contains(email)) {
      final newParticipants = <String>[email, ...participants.value];

      emit(
        state.copyWith(
          participants: ListFormInput<String>.dirty(newParticipants),
          status: Formz.validate([
            ListFormInput<String>.dirty(newParticipants),
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
    final existingParticipants = participants.value.where((participant) => participant != email).toList();
    final newParticipants = existingParticipants.where((item) => !initialValues.value.contains(item)).toList();

    emit(
      state.copyWith(
        participants: ListFormInput<String>.dirty(existingParticipants),
        status: Formz.validate([
          ListFormInput<String>.dirty(newParticipants),
        ]),
      ),
    );
  }
}
