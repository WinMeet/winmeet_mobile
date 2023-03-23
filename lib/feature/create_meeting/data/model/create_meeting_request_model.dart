import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_meeting_request_model.freezed.dart';
part 'create_meeting_request_model.g.dart';

@freezed
class CreateMeetingRequestModel with _$CreateMeetingRequestModel {
  const factory CreateMeetingRequestModel({
    required String eventName,
    required String eventDescription,
    required String location,
    required String eventStartDate,
    required String eventFinishDate,
    required List<String> participants,
  }) = _CreateMeetingRequestModel;

  factory CreateMeetingRequestModel.fromJson(Map<String, dynamic> json) => _$CreateMeetingRequestModelFromJson(json);
}
