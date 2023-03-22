import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:winmeet_mobile/app/router/app_router.gr.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/extensions/widget_extesions.dart';
import 'package:winmeet_mobile/core/utils/calendar/calendar_utils.dart';
import 'package:winmeet_mobile/core/utils/date_time_picker/date_time_picker_utils.dart';
import 'package:winmeet_mobile/core/utils/snackbar/snackbar_utils.dart';
import 'package:winmeet_mobile/feature/create_meeting/presentation/cubit/create_meeting_cubit.dart';
import 'package:winmeet_mobile/presentation/widgets/input/normal_input_field.dart';

class CreateMeetingView extends StatelessWidget {
  const CreateMeetingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateMeetingCubit(),
      child: const _CreateMeetingScaffold(),
    );
  }
}

class _CreateMeetingScaffold extends StatelessWidget {
  const _CreateMeetingScaffold();

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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: Padding(
        padding: context.paddingAllDefault,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const NormalInputField(
                labelText: 'Meeting Title',
                errorLabel: 'This field cannot be empty',
                textInputAction: TextInputAction.next,
                isValid: false,
              ),
              const NormalInputField(
                labelText: 'Meeting Description',
                textInputAction: TextInputAction.next,
              ),
              const NormalInputField(
                labelText: 'Location',
                textInputAction: TextInputAction.next,
              ),
              const _DateTimePicker(),
              const _Participants(),
            ].withSpaceBetween(height: context.mediumValue),
          ),
        ),
      ),
    );
  }
}

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
          builder: (context, state) => _DateTimeTile(
            label: 'Starts',
            dateTime: state.startDateTime,
            onTap: () => _onStartTimeSelected(context, state),
          ),
        ),
        BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
          builder: (context, state) => _DateTimeTile(
            label: 'Ends',
            dateTime: state.endDateTime,
            onTap: () => _onEndTimeSelected(context, state),
          ),
        ),
      ],
    );
  }

  Future<void> _onStartTimeSelected(BuildContext context, CreateMeetingState state) async {
    final selectedStartTime = await DateTimePickerUtils.pickDateTime(
      context: context,
      initialTime: state.startDateTime,
      datePickerHelpText: 'Select Start Date',
      timePickerHelpText: 'Select Start Time',
      cancelText: 'Cancel',
      confirmText: 'Confirm',
    );

    if (context.mounted && selectedStartTime != null) {
      if (selectedStartTime.isAfter(state.endDateTime)) {
        final endDateTime = selectedStartTime.add(const Duration(hours: 1));
        context.read<CreateMeetingCubit>().setStartAndEndDateTime(
              startDateTime: selectedStartTime,
              endDateTime: endDateTime,
            );
      } else if (selectedStartTime.isBefore(CalendarUtils.today)) {
        SnackbarUtils.showSnackbar(
          context: context,
          message: 'Event cannot start earlier than now',
        );
      } else {
        context.read<CreateMeetingCubit>().setStartDateTime(startDateTime: selectedStartTime);
      }
    }
  }

  Future<void> _onEndTimeSelected(BuildContext context, CreateMeetingState state) async {
    final selectedEndTime = await DateTimePickerUtils.pickDateTime(
      context: context,
      initialTime: state.endDateTime,
      datePickerHelpText: 'Select End Date',
      timePickerHelpText: 'Select End Time',
      cancelText: 'Cancel',
      confirmText: 'Confirm',
    );

    if (context.mounted && selectedEndTime != null) {
      if (selectedEndTime.isBefore(state.startDateTime)) {
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
        context.read<CreateMeetingCubit>().setEndDateTime(endDateTime: selectedEndTime);
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
  final DateTime dateTime;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        label,
        style: context.textTheme.bodyLarge,
      ),
      trailing: Text(
        DateFormat.yMMMd().add_jm().format(dateTime),
        style: context.textTheme.bodyLarge,
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
          leading: Text(
            'Participants',
            style: context.textTheme.bodyLarge,
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
                state.participants.length,
                (index) => Chip(
                  deleteButtonTooltipMessage: '',
                  label: Text(state.participants[index].substring(0, 12)),
                  onDeleted: () => context.read<CreateMeetingCubit>().removeParticipantFromParticipants(
                        email: state.participants[index],
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
