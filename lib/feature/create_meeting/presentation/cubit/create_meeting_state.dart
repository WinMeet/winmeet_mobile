part of 'create_meeting_cubit.dart';

@freezed
class CreateMeetingState with _$CreateMeetingState {
  const factory CreateMeetingState({
    required FormzStatus status,
    required DateTime startDateTime,
    required DateTime endDateTime,
    required Email email,
    required List<String> participants,
  }) = _CreateMeetingState;

  factory CreateMeetingState.initial() => CreateMeetingState(
        status: FormzStatus.pure,
        startDateTime: CalendarUtils.initialStartDate,
        endDateTime: CalendarUtils.initialEndDate,
        email: const Email.pure(),
        participants: [],
      );
}
