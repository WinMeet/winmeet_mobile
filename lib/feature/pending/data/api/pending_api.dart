import 'package:injectable/injectable.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:winmeet_mobile/app/constants/cache_contants.dart';
import 'package:winmeet_mobile/app/constants/endpoints.dart';
import 'package:winmeet_mobile/core/clients/cache/cache_client.dart';
import 'package:winmeet_mobile/core/clients/network/network_client.dart';
import 'package:winmeet_mobile/feature/schedule/data/model/event_model.dart';

@injectable
class PendingApi {
  PendingApi({required NetworkClient networkClient, required CacheClient cacheClient})
      : _networkClient = networkClient,
        _cacheClient = cacheClient;

  final NetworkClient _networkClient;
  final CacheClient _cacheClient;

  Future<List<EventModel>> getPendingMeetings() async {
    try {
      final token = _cacheClient.getString(CacheConstants.token);
      if (token == null) {
        throw Exception('No token found');
      }
      final jwt = Jwt.parseJwt(token);
      final response = await _networkClient.post<Map<String, dynamic>>(
        Endpoints.getPendingMeetings,
        data: {
          'eventOwner': jwt['email'],
        },
      );

      final model = response.data?['combined'] as List?;
      if (model == null) {
        throw Exception('Null data getPendingMeetings()');
      } else {
        return model.map((e) => EventModel.fromJson(e as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> voteMeetingDate({required String eventId, required int dateIndex}) async {
    try {
      final token = _cacheClient.getString(CacheConstants.token);
      if (token == null) {
        throw Exception('No token found');
      }
      final jwt = Jwt.parseJwt(token);

      await _networkClient.put<Map<String, dynamic>>(
        "${Endpoints.voteMeetingDate}/$eventId/${jwt['email']}",
        data: {'fieldToIncrement': dateIndex},
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}