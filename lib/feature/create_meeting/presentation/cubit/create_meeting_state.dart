part of 'create_meeting_cubit.dart';

@freezed
class CreateMeetingState with _$CreateMeetingState {
  const factory CreateMeetingState({
    required DateTime startDateTime,
    required DateTime endDateTime,
  }) = _CreateMeetingState;

  factory CreateMeetingState.initial() => CreateMeetingState(
        startDateTime: CalendarUtils.initialStartDate,
        endDateTime: CalendarUtils.initialEndDate,
      );
}
