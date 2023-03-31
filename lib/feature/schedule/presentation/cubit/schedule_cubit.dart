import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:winmeet_mobile/app/utils/calendar/calendar_utils.dart';
import 'package:winmeet_mobile/core/enums/page_status.dart';

import 'package:winmeet_mobile/feature/schedule/data/model/event_model.dart';
import 'package:winmeet_mobile/feature/schedule/data/repository/schedule_repository.dart';

part 'schedule_state.dart';
part 'schedule_cubit.freezed.dart';

@injectable
class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit({required ScheduleRepository scheduleRepository})
      : _scheduleRepository = scheduleRepository,
        super(ScheduleState.initial());

  final ScheduleRepository _scheduleRepository;

  Future<void> getAllMeetings() async {
    emit(state.copyWith(status: PageStatus.loading));

    final response = await _scheduleRepository.getAllMeetings();
    // TODO: remove
    await Future.delayed(const Duration(seconds: 1));

    response.fold(
      // TODO:  emit(state.copyWith(status: PageStatus.failure))
      (failure) => emit(state.copyWith(status: PageStatus.success, allEvents: ScheduleState.initial().allEvents)),
      // TODO: replace with (success) => emit(state.copyWith(events: success)
      (success) => emit(state.copyWith(status: PageStatus.success, allEvents: ScheduleState.initial().allEvents)),
    );
  }

  List<EventModel> getByDay(DateTime date) {
    return state.allEvents.where((event) => isSameDay(date, event.eventStartDate)).toList();
  }

  void updateFocusedDay(DateTime focusedDay) {
    emit(state.copyWith(focusedDay: focusedDay));
  }
}
