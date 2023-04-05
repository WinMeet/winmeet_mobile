import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/core/model/failure/failure_model.dart';
import 'package:winmeet_mobile/feature/schedule/data/api/schedule_api.dart';
import 'package:winmeet_mobile/feature/schedule/data/model/event_model.dart';

@injectable
class ScheduleRepository {
  ScheduleRepository({required ScheduleApi scheduleApi}) : _scheduleApi = scheduleApi;

  final ScheduleApi _scheduleApi;

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
}
