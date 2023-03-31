import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/constants/endpoints.dart';
import 'package:winmeet_mobile/core/network/network_client.dart';

import 'package:winmeet_mobile/feature/schedule/data/model/event_model.dart';

@injectable
class ScheduleApi {
  ScheduleApi({required NetworkClient networkClient}) : _networkClient = networkClient;

  final NetworkClient _networkClient;

  Future<List<EventModel>> getAllMeetings() async {
    try {
      final response = await _networkClient.get<Map<String, dynamic>>(Endpoints.getAllMeetings);

      final model = response.data?['eventData'] as List?;
      if (model == null) {
        throw Exception('Null data getAllMeetings()');
      } else {
        return model.map((e) => EventModel.fromJson(e as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
