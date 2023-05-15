// ignore_for_file: cascade_invocations

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/core/enums/page_status.dart';
import 'package:winmeet_mobile/feature/pending/data/repository/pending_repository.dart';
import 'package:winmeet_mobile/feature/schedule/data/model/event_model.dart';

part 'pending_cubit.freezed.dart';
part 'pending_state.dart';

@injectable
class PendingCubit extends Cubit<PendingState> {
  PendingCubit({required PendingRepository pendingRepository})
      : _pendingRepository = pendingRepository,
        super(PendingState.initial());

  final PendingRepository _pendingRepository;

  Future<void> getPendingMeetings() async {
    emit(state.copyWith(status: PageStatus.loading));

    final response = await _pendingRepository.getPendingMeetings();

    response.fold(
      (failure) => emit(state.copyWith(status: PageStatus.failure)),
      (success) => emit(state.copyWith(status: PageStatus.success, events: success)),
    );
  }

  Future<void> voteMeetingDate({required String eventId, required int dateIndex}) async {
    emit(state.copyWith(eventStatus: PageStatus.loading));
    final response = await _pendingRepository.voteMeetingDate(eventId: eventId, dateIndex: dateIndex);

    response.fold((failure) => emit(state.copyWith(status: PageStatus.failure, eventStatus: PageStatus.failure)),
        (success) {
      final events = state.events;
      final newEvents = events.where((event) => event.id != eventId).toList();
      emit(state.copyWith(status: PageStatus.success, eventStatus: PageStatus.success, events: newEvents));
    });
  }
}
