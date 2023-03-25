part of 'create_meeting_cubit.dart';

@freezed
class CreateMeetingState with _$CreateMeetingState {
  const factory CreateMeetingState({
    required FormzStatus status,
    required InputFormField title,
    required InputFormField description,
    required InputFormField location,
    required DateTime startDateTime,
    required DateTime endDateTime,
    required ListFormInput<String> participants,
    required EmailFormInput email,
  }) = _CreateMeetingState;

  factory CreateMeetingState.initial() => CreateMeetingState(
        status: FormzStatus.pure,
        title: const InputFormField.pure(),
        description: const InputFormField.pure(isRequired: false),
        location: const InputFormField.pure(isRequired: false),
        startDateTime: CalendarUtils.initialStartDate,
        endDateTime: CalendarUtils.initialEndDate,
        participants: ListFormInput.pure(),
        email: const EmailFormInput.pure(),
      );
}
