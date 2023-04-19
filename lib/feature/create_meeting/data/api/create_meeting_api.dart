import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/constants/endpoints.dart';
import 'package:winmeet_mobile/core/clients/network/network_client.dart';

import 'package:winmeet_mobile/feature/create_meeting/data/model/create_meeting_request_model.dart';

@injectable
class CreateMeetingApi {
  CreateMeetingApi({required NetworkClient networkClient}) : _networkClient = networkClient;

  final NetworkClient _networkClient;

  Future<void> createMeeting({required CreateMeetingRequestModel createMeetingRequestModel}) async {
    try {
      await _networkClient.post<Map<String, dynamic>>(
        Endpoints.createMeeting,
        data: createMeetingRequestModel.toJson(),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
