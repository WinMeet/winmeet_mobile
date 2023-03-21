import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:winmeet_mobile/core/utils/calendar/calendar_utils.dart';

part 'create_meeting_state.dart';
part 'create_meeting_cubit.freezed.dart';

class CreateMeetingCubit extends Cubit<CreateMeetingState> {
  CreateMeetingCubit() : super(CreateMeetingState.initial());

  void setStartDateTime({required DateTime startDateTime}) {
    emit(state.copyWith(startDateTime: startDateTime));
  }

  void setEndDateTime({required DateTime endDateTime}) {
    emit(state.copyWith(endDateTime: endDateTime));
  }

  void setStartAndEndDateTime({required DateTime startDateTime, required DateTime endDateTime}) {
    emit(state.copyWith(startDateTime: startDateTime, endDateTime: endDateTime));
  }
}
