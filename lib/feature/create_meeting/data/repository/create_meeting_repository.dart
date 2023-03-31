import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/core/model/failure/failure_model.dart';
import 'package:winmeet_mobile/feature/create_meeting/data/api/create_meeting_api.dart';
import 'package:winmeet_mobile/feature/create_meeting/data/model/create_meeting_request_model.dart';

@injectable
class CreateMeetingRepository {
  CreateMeetingRepository({required CreateMeetingApi createMeetingApi}) : _createMeetingApi = createMeetingApi;

  final CreateMeetingApi _createMeetingApi;

  Future<Either<FailureModel, void>> createMeeting({
    required CreateMeetingRequestModel createMeetingRequestModel,
  }) async {
    try {
      final response = await _createMeetingApi.createMeeting(createMeetingRequestModel: createMeetingRequestModel);
      return right(response);
    } catch (e) {
      log(e.toString());
      return left(const FailureModel());
    }
  }
}
