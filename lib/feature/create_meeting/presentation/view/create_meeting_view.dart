import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:winmeet_mobile/app/router/app_router.gr.dart';
import 'package:winmeet_mobile/app/utils/calendar/calendar_utils.dart';
import 'package:winmeet_mobile/app/widgets/input/text_input_field.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_body_large.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/extensions/widget_extesions.dart';
import 'package:winmeet_mobile/core/utils/date_format/date_format_utils.dart';
import 'package:winmeet_mobile/core/utils/date_time_picker/date_time_picker_utils.dart';
import 'package:winmeet_mobile/core/utils/snackbar/snackbar_utils.dart';
import 'package:winmeet_mobile/feature/create_meeting/presentation/cubit/create_meeting_cubit.dart';
import 'package:winmeet_mobile/feature/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:winmeet_mobile/injection.dart';

class CreateMeetingView extends StatelessWidget {
  const CreateMeetingView({required ScheduleCubit cubit, super.key}) : _cubit = cubit;

  final ScheduleCubit _cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateMeetingCubit>(),
      child: _CreateMeetingScaffold(cubit: _cubit),
    );
  }
}

class _CreateMeetingScaffold extends StatelessWidget {
  const _CreateMeetingScaffold({required ScheduleCubit cubit}) : _cubit = cubit;

  final ScheduleCubit _cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Meeting'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => context.router.pop(),
          icon: const Icon(Icons.close),
        ),
        actions: [
          BlocConsumer<CreateMeetingCubit, CreateMeetingState>(
            listener: (context, state) {
              if (state.status.isSubmissionSuccess) {
                context.router.pop();
                SnackbarUtils.showSnackbar(
                  context: context,
                  message: 'Meeting has been scheduled and emails have been sent out to all participants.',
                );
              } else if (state.status.isSubmissionFailure) {
                SnackbarUtils.showSnackbar(
                  context: context,
                  message: 'An error occured while creating meeting.',
                );
              }
            },
            builder: (context, state) {
              return IconButton(
                onPressed: state.status.isValid || state.status.isSubmissionFailure
                    ? () async {
                        await context.read<CreateMeetingCubit>().createMeeting();
                        await _cubit.getAllMeetings();
                      }
                    : null,
                icon: const Icon(Icons.done),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: context.paddingAllDefault,
            child: Column(
              children: [
                BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
                  builder: (context, state) {
                    return TextInputField(
                      labelText: 'Meeting Title *',
                      errorLabel: 'Title cannot be empty',
                      textInputAction: TextInputAction.next,
                      isValid: state.title.invalid,
                      onChanged: (title) => context.read<CreateMeetingCubit>().titleChanged(title: title),
                    );
                  },
                ),
                BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
                  builder: (context, state) {
                    return TextInputField(
                      labelText: 'Meeting Description',
                      textInputAction: TextInputAction.next,
                      onChanged: (description) =>
                          context.read<CreateMeetingCubit>().descriptionChanged(description: description),
                    );
                  },
                ),
                BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
                  builder: (context, state) {
                    return TextInputField(
                      labelText: 'Location',
                      textInputAction: TextInputAction.next,
                      onChanged: (location) => context.read<CreateMeetingCubit>().locationChanged(location: location),
                    );
                  },
                ),
                ExpansionTile(
                  title: const WinMeetBodyLarge(text: 'Date & Time *'),
                  children: [
                    BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
                      builder: (context, state) {
                        return _DateTimePicker(
                          startDateTime: state.startDateTime,
                          endDateTime: state.endDateTime,
                          index: 0,
                        );
                      },
                    )
                  ],
                ),
                ExpansionTile(
                  title: const WinMeetBodyLarge(text: 'Date & Time (Optional 1)'),
                  children: [
                    BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
                      builder: (context, state) {
                        return _DateTimePicker(
                          startDateTime: state.startDateTime2,
                          endDateTime: state.endDateTime2,
                          index: 1,
                        );
                      },
                    )
                  ],
                ),
                ExpansionTile(
                  title: const WinMeetBodyLarge(text: 'Date & Time (Optional 2)'),
                  children: [
                    BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
                      builder: (context, state) {
                        return _DateTimePicker(
                          startDateTime: state.startDateTime3,
                          endDateTime: state.endDateTime3,
                          index: 2,
                        );
                      },
                    )
                  ],
                ),
                const _Participants(),
              ].withSpaceBetween(height: context.mediumValue),
            ),
          ),
        ),
      ),
    );
  }
}

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker({required this.startDateTime, required this.endDateTime, required this.index});

  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DateTimeTile(
          label: 'Starts',
          dateTime: startDateTime,
          onTap: () => _onStartTimeSelected(
            context,
            startDateTime ?? CalendarUtils.initialStartDate,
            endDateTime ?? CalendarUtils.initialEndDate,
          ),
        ),
        _DateTimeTile(
          label: 'Ends',
          dateTime: endDateTime,
          onTap: () => _onEndTimeSelected(
            context,
            startDateTime ?? CalendarUtils.initialStartDate,
            endDateTime ?? CalendarUtils.initialEndDate,
          ),
        ),
      ],
    );
  }

  Future<void> _onStartTimeSelected(BuildContext context, DateTime startDateTime, DateTime endDateTime) async {
    final selectedStartTime = await DateTimePickerUtils.pickDateTime(
      context: context,
      initialTime: startDateTime,
      firstDate: CalendarUtils.today,
      lastDate: CalendarUtils.lastDay,
      datePickerHelpText: 'Select Start Date',
      timePickerHelpText: 'Select Start Time',
      cancelText: 'Cancel',
      confirmText: 'Confirm',
    );

    if (context.mounted && selectedStartTime != null) {
      if (selectedStartTime.isAfter(endDateTime)) {
        final endDateTime = selectedStartTime.add(const Duration(hours: 1));
        context.read<CreateMeetingCubit>().setStartAndEndDateTime(
              startDateTime: selectedStartTime,
              endDateTime: endDateTime,
              index: index,
            );
      } else if (selectedStartTime.isBefore(CalendarUtils.today)) {
        SnackbarUtils.showSnackbar(
          context: context,
          message: 'Event cannot start earlier than now',
        );
      } else {
        context.read<CreateMeetingCubit>().setStartDateTime(startDateTime: selectedStartTime, index: index);
      }
    }
  }

  Future<void> _onEndTimeSelected(BuildContext context, DateTime startDateTime, DateTime endDateTime) async {
    final selectedEndTime = await DateTimePickerUtils.pickDateTime(
      context: context,
      initialTime: endDateTime,
      firstDate: CalendarUtils.today,
      lastDate: CalendarUtils.lastDay,
      datePickerHelpText: 'Select End Date',
      timePickerHelpText: 'Select End Time',
      cancelText: 'Cancel',
      confirmText: 'Confirm',
    );

    if (context.mounted && selectedEndTime != null) {
      if (selectedEndTime.isBefore(startDateTime)) {
        SnackbarUtils.showSnackbar(
          context: context,
          message: 'Event cannot end earlier start date',
        );
      } else if (selectedEndTime.isBefore(CalendarUtils.today)) {
        SnackbarUtils.showSnackbar(
          context: context,
          message: 'Event cannot start earlier than now',
        );
      } else {
        context.read<CreateMeetingCubit>().setEndDateTime(endDateTime: selectedEndTime, index: index);
      }
    }
  }
}

class _DateTimeTile extends StatelessWidget {
  const _DateTimeTile({
    required this.label,
    required this.dateTime,
    required this.onTap,
  });
  final String label;
  final DateTime? dateTime;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: WinMeetBodyLarge(
        text: label,
      ),
      trailing: WinMeetBodyLarge(
        text: dateTime != null ? DateFormatUtils.getMonthDayYearHour(dateTime!) : 'Not Set',
      ),
      onTap: onTap,
    );
  }
}

class _Participants extends StatelessWidget {
  const _Participants();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const WinMeetBodyLarge(
            text: 'Participants *',
          ),
          trailing: const Icon(Icons.add),
          onTap: () async {
            await context.router.push(AddParticipantsRoute(cubit: context.read<CreateMeetingCubit>()));
            if (context.mounted) context.read<CreateMeetingCubit>().resetAddParticipantsVariables();
          },
        ),
        BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
          builder: (context, state) {
            return Wrap(
              runSpacing: context.lowValue,
              spacing: context.lowValue,
              children: List.generate(
                state.participants.value.length,
                (index) => Chip(
                  deleteButtonTooltipMessage: '',
                  label: Text(state.participants.value[index]),
                  onDeleted: () => context.read<CreateMeetingCubit>().removeParticipantFromParticipants(
                        email: state.participants.value[index],
                      ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
