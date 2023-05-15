import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:winmeet_mobile/app/constants/cache_contants.dart';
import 'package:winmeet_mobile/core/clients/cache/cache_client.dart';
import 'package:winmeet_mobile/core/model/failure/failure_model.dart';
import 'package:winmeet_mobile/feature/pending/data/api/pending_api.dart';
import 'package:winmeet_mobile/feature/schedule/data/model/event_model.dart';

@injectable
class PendingRepository {
  PendingRepository({required PendingApi pendingApi, required CacheClient cacheClient})
      : _pendingApi = pendingApi,
        _cacheClient = cacheClient;

  final PendingApi _pendingApi;
  final CacheClient _cacheClient;

  Future<Either<FailureModel, List<EventModel>>> getPendingMeetings() async {
    try {
      final response = await _pendingApi.getPendingMeetings();
      final token = _cacheClient.getString(CacheConstants.token);
      final jwt = Jwt.parseJwt(token!);
      final email = jwt['email'] as String;

      final filteredResponse = response
          .where((event) => event.isPending && !event.voters.contains(email) && event.eventOwner != email)
          .toList();

      return right(filteredResponse);
    } catch (e) {
      log(e.toString());
      return left(const FailureModel());
    }
  }

  Future<Either<FailureModel, void>> voteMeetingDate({required String eventId, required int dateIndex}) async {
    try {
      final response = await _pendingApi.voteMeetingDate(eventId: eventId, dateIndex: dateIndex);
      return right(response);
    } catch (e) {
      log(e.toString());
      return left(const FailureModel());
    }
  }
}
