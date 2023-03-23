import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/exceptions/auth_exceptions.dart';
import 'package:winmeet_mobile/feature/create_meeting/data/api/create_meeting_api.dart';
import 'package:winmeet_mobile/feature/create_meeting/data/model/create_meeting_request_model.dart';

@injectable
class CreateMeetingRepository {
  CreateMeetingRepository({required CreateMeetingApi createMeetingApi}) : _createMeetingApi = createMeetingApi;

  final CreateMeetingApi _createMeetingApi;

  Future<void> createMeeting({required CreateMeetingRequestModel createMeetingRequestModel}) async {
    try {
      await _createMeetingApi.createMeeting(createMeetingRequestModel: createMeetingRequestModel);
    } catch (_) {
      throw const CreateMeetingFailure();
    }
  }
}
