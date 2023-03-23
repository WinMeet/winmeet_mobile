part of 'create_meeting_cubit.dart';

@freezed
class CreateMeetingState with _$CreateMeetingState {
  const factory CreateMeetingState({
    required FormzStatus status,
    required InputField title,
    required InputField description,
    required InputField location,
    required DateTime startDateTime,
    required DateTime endDateTime,
    required ListFormValidator<String> participants,
    required Email email,
    String? errorMessage,
  }) = _CreateMeetingState;

  factory CreateMeetingState.initial() => CreateMeetingState(
        status: FormzStatus.pure,
        title: const InputField.pure(),
        description: const InputField.pure(isRequired: false),
        location: const InputField.pure(isRequired: false),
        startDateTime: CalendarUtils.initialStartDate,
        endDateTime: CalendarUtils.initialEndDate,
        participants: ListFormValidator.pure(),
        email: const Email.pure(),
      );
}
