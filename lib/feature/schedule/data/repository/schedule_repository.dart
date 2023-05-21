import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/constants/cache_contants.dart';
import 'package:winmeet_mobile/app/utils/jwt/jwt_utils.dart';
import 'package:winmeet_mobile/core/clients/cache/cache_client.dart';
import 'package:winmeet_mobile/core/model/failure/failure_model.dart';
import 'package:winmeet_mobile/feature/schedule/data/api/schedule_api.dart';
import 'package:winmeet_mobile/feature/schedule/data/model/event_model.dart';

@injectable
class ScheduleRepository {
  ScheduleRepository({required ScheduleApi scheduleApi, required CacheClient cacheClient})
      : _scheduleApi = scheduleApi,
        _cacheClient = cacheClient;

  final ScheduleApi _scheduleApi;
  final CacheClient _cacheClient;

  Future<Either<FailureModel, List<EventModel>>> getAllMeetings() async {
    try {
      final response = await _scheduleApi.getAllMeetings();
      return right(response);
    } catch (e) {
      log(e.toString());
      return left(const FailureModel());
    }
  }

  Future<Either<FailureModel, void>> deleteMeeting(String id) async {
    try {
      final response = await _scheduleApi.deleteMeeting(id);
      return right(response);
    } catch (e) {
      log(e.toString());
      return left(const FailureModel());
    }
  }

  bool isOwner({required String email}) {
    final token = _cacheClient.getString(CacheConstants.token);
    final emailToken = JwtUtils.getEmailFromToken(token: token!);
    if (emailToken == email) {
      return true;
    }
    return false;
  }

  bool isVoted({required List<String> participants}) {
    final token = _cacheClient.getString(CacheConstants.token);
    final emailToken = JwtUtils.getEmailFromToken(token: token!);
    if (participants.contains(emailToken)) {
      return true;
    }
    return false;
  }
}
