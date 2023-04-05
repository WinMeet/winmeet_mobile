// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    @JsonKey(name: '_id') required String id,
    required String eventName,
    required String eventDescription,
    required String location,
    required DateTime eventStartDate,
    required DateTime eventEndDate,
    required List<String> participants,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) => _$EventModelFromJson(json);
}
