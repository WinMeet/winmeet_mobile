part of 'schedule_cubit.dart';

@freezed
class ScheduleState with _$ScheduleState {
  const factory ScheduleState({
    required PageStatus status,
    required DateTime focusedDay,
    required List<EventModel> allEvents,
  }) = _ScheduleState;

  factory ScheduleState.initial() => ScheduleState(
        status: PageStatus.loading,
        focusedDay: CalendarUtils.today,
        // TODO: List.empty()
        allEvents: mockedEvents,
      );
}

List<EventModel> mockedEvents = [
  EventModel(
    eventName: 'Meeting with John',
    description: 'Discuss project progress and next steps.',
    location: 'Conference Room A',
    eventStartDate: DateTime(2023, 3, 31, 10),
    eventEndDate: DateTime(2023, 4, 1, 11),
    participants: ['Alice', 'Bob', 'John'],
  ),
  EventModel(
    eventName: 'Meeting with Susan',
    description: 'Discuss project progress and next steps.',
    location: 'Conference Room A',
    eventStartDate: DateTime(2023, 3, 31, 10),
    eventEndDate: DateTime(2023, 4, 1, 11),
    participants: ['Alice', 'Bob', 'John'],
  ),
  EventModel(
    eventName: 'Lunch with Susan',
    description: 'Catch up and discuss collaboration opportunities.',
    location: 'Cafeteria',
    eventStartDate: DateTime(2023, 3, 28, 13, 30),
    eventEndDate: DateTime(2023, 4, 2, 13, 30),
    participants: ['Alice', 'Susan'],
  ),
  EventModel(
    eventName: 'Team Workshop',
    description: 'Brainstorming and team building activities.',
    location: 'Conference Room B',
    eventStartDate: DateTime(2023, 4, 2, 14),
    eventEndDate: DateTime(2023, 4, 3, 17),
    participants: ['Alice', 'Bob', 'John', 'Susan', 'Emma', 'Tom'],
  ),
];
