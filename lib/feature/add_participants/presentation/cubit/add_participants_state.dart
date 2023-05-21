part of 'add_participants_cubit.dart';

@freezed
class AddParticipantsState with _$AddParticipantsState {
  const factory AddParticipantsState({
    required FormzStatus status,
    required ListFormInput<String> participants,
    required EmailFormInput email,
  }) = _AddParticipantsState;

  factory AddParticipantsState.initial() => AddParticipantsState(
        status: FormzStatus.pure,
        participants: ListFormInput.pure(),
        email: const EmailFormInput.pure(),
      );
}
