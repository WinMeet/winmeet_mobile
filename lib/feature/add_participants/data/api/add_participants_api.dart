import 'package:injectable/injectable.dart';

import 'package:winmeet_mobile/app/constants/endpoints.dart';
import 'package:winmeet_mobile/core/clients/network/network_client.dart';

@injectable
class AddParticipantsApi {
  AddParticipantsApi({required NetworkClient networkClient}) : _networkClient = networkClient;

  final NetworkClient _networkClient;

  Future<void> updateMeetingParticipants({required String id, required List<String> participants}) async {
    try {
      await _networkClient.put<Map<String, dynamic>>(
        '${Endpoints.addParticipant}/$id',
        data: {
          'participants': participants,
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
