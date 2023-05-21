import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:winmeet_mobile/core/model/failure/failure_model.dart';

import 'package:winmeet_mobile/feature/add_participants/data/api/add_participants_api.dart';

@injectable
class AddParticipantsRepository {
  AddParticipantsRepository({required AddParticipantsApi addParticipantsApi})
      : _addParticipantsApi = addParticipantsApi;

  final AddParticipantsApi _addParticipantsApi;

  Future<Either<FailureModel, void>> updateMeetingParticipants({
    required String id,
    required List<String> participants,
  }) async {
    try {
      final response = await _addParticipantsApi.updateMeetingParticipants(id: id, participants: participants);
      return right(response);
    } catch (e) {
      log(e.toString());
      return left(const FailureModel());
    }
  }
}
