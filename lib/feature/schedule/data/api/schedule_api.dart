import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/constants/cache_contants.dart';
import 'package:winmeet_mobile/app/constants/endpoints.dart';
import 'package:winmeet_mobile/app/utils/jwt/jwt_utils.dart';
import 'package:winmeet_mobile/core/clients/cache/cache_client.dart';
import 'package:winmeet_mobile/core/clients/network/network_client.dart';

import 'package:winmeet_mobile/feature/schedule/data/model/event_model.dart';

@injectable
class ScheduleApi {
  ScheduleApi({required NetworkClient networkClient, required CacheClient cacheClient})
      : _networkClient = networkClient,
        _cacheClient = cacheClient;

  final NetworkClient _networkClient;
  final CacheClient _cacheClient;

  Future<List<EventModel>> getAllMeetings() async {
    try {
      final token = _cacheClient.getString(CacheConstants.token);
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await _networkClient.post<Map<String, dynamic>>(
        Endpoints.getAllMeetings,
        data: {
          'eventOwner': JwtUtils.getEmailFromToken(token: token),
        },
      );

      final model = response.data?['combined'] as List?;
      if (model == null) {
        throw Exception('Null data getAllMeetings()');
      } else {
        return model.map((e) => EventModel.fromJson(e as Map<String, dynamic>)).toList()
          ..sort((a, b) => a.eventStartDate.compareTo(b.eventStartDate));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteMeeting(String id) async {
    try {
      await _networkClient.delete<Map<String, dynamic>>(Endpoints.deleteMeeting + id);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> iCannotAttend({required String id}) async {
    try {
      final token = _cacheClient.getString(CacheConstants.token);
      if (token == null) {
        throw Exception('No token found');
      }
      await _networkClient.put<Map<String, dynamic>>(
        '${Endpoints.iCannotAttend}/$id',
        data: {
          'participants': [JwtUtils.getEmailFromToken(token: token)],
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
