import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_meeting_request_model.freezed.dart';
part 'create_meeting_request_model.g.dart';

@freezed
class CreateMeetingRequestModel with _$CreateMeetingRequestModel {
  const factory CreateMeetingRequestModel({
    required String eventOwner,
    required String eventName,
    required String eventDescription,
    required String location,
    required String eventStartDate,
    required String eventEndDate,
    required List<String> participants,
    String? eventStartDate2,
    String? eventEndDate2,
    String? eventStartDate3,
    String? eventEndDate3,
  }) = _CreateMeetingRequestModel;

  factory CreateMeetingRequestModel.fromJson(Map<String, dynamic> json) => _$CreateMeetingRequestModelFromJson(json);
}
