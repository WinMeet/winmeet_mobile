part of 'pending_cubit.dart';

@freezed
class PendingState with _$PendingState {
  const factory PendingState({
    required PageStatus status,
    required PageStatus eventStatus,
    required List<EventModel> events,
  }) = _PendingState;

  factory PendingState.initial() => PendingState(
        status: PageStatus.initial,
        eventStatus: PageStatus.initial,
        events: List.empty(),
      );
}
