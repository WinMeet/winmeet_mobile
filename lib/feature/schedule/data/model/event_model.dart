// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    @JsonKey(name: '_id') required String id,
    required String eventOwner,
    required String eventName,
    required String eventDescription,
    required String location,
    required DateTime eventStartDate,
    required DateTime eventEndDate,
    required bool isPending,
    @JsonKey(name: 'eventVoteDuration') required DateTime voteDueDate,
    required DateTime? eventStartDate2,
    required DateTime? eventEndDate2,
    required DateTime? eventStartDate3,
    required DateTime? eventEndDate3,
    required List<String> participants,
    required List<String> voters,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) => _$EventModelFromJson(json);

  const EventModel._();

  List<EventDate> getEventStartDates() {
    // ignore: prefer_final_locals
    var eventDates = [EventDate(eventStartDate: eventStartDate, eventEndDate: eventEndDate, index: 0)];
    if (eventStartDate2 != null && eventEndDate2 != null) {
      eventDates.add(EventDate(eventStartDate: eventStartDate2!, eventEndDate: eventEndDate2!, index: 1));
    }
    if (eventStartDate3 != null && eventEndDate3 != null) {
      eventDates.add(EventDate(eventStartDate: eventStartDate3!, eventEndDate: eventEndDate3!, index: 2));
    }
    return eventDates;
  }
}

class EventDate {
  EventDate({required this.eventStartDate, required this.eventEndDate, required this.index});

  final DateTime eventStartDate;
  final DateTime eventEndDate;
  final int index;
}
