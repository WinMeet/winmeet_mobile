import 'package:bloc/bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:winmeet_mobile/core/utils/calendar/calendar_utils.dart';

part 'create_meeting_state.dart';
part 'create_meeting_cubit.freezed.dart';

class CreateMeetingCubit extends Cubit<CreateMeetingState> {
  CreateMeetingCubit() : super(CreateMeetingState.initial());

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
    final newEmail = Email.dirty(email);
    emit(state.copyWith(email: newEmail, status: Formz.validate([newEmail])));
  }

  void resetAddParticipantsVariables() {
    emit(state.copyWith(email: const Email.pure()));
  }

  bool addParticipantToParticipants({required String email}) {
    final participants = state.participants;
    if (!participants.contains(email)) {
      final newParticipants = <String>[email, ...participants];
      emit(state.copyWith(participants: newParticipants, email: const Email.pure()));
      return true;
    }
    return false;
  }

  void removeParticipantFromParticipants({required String email}) {
    final participants = state.participants;
    final newParticipants = participants.where((participant) => participant != email).toList();

    emit(state.copyWith(participants: newParticipants));
  }
}
