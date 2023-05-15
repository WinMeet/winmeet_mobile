part of 'schedule_cubit.dart';

@freezed
class ScheduleState with _$ScheduleState {
  const factory ScheduleState({
    required PageStatus status,
    required DateTime focusedDay,
    required List<EventModel> allEvents,
  }) = _ScheduleState;

  factory ScheduleState.initial() => ScheduleState(
        status: PageStatus.initial,
        focusedDay: CalendarUtils.today,
        allEvents: List.empty(),
      );
}
