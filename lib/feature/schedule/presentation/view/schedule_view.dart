import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:winmeet_mobile/app/router/app_router.gr.dart';
import 'package:winmeet_mobile/app/widgets/calendar/winmeet_calendar.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_body_large.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_title_large.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_title_medium.dart';
import 'package:winmeet_mobile/core/enums/page_status.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/extensions/widget_extesions.dart';
import 'package:winmeet_mobile/core/utils/date_format/date_format_utils.dart';
import 'package:winmeet_mobile/core/utils/snackbar/snackbar_utils.dart';
import 'package:winmeet_mobile/feature/schedule/data/model/event_model.dart';
import 'package:winmeet_mobile/feature/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:winmeet_mobile/injection.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ScheduleCubit>()..getAllMeetings(),
      child: const _ScheduleViewScaffold(),
    );
  }
}

class _ScheduleViewScaffold extends StatelessWidget {
  const _ScheduleViewScaffold();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleCubit, ScheduleState>(
      builder: (context, state) {
        switch (state.status) {
          case PageStatus.initial:
          case PageStatus.loading:
            return _buildLoadingState();

          case PageStatus.failure:
            return _buildFailureState(context);

          case PageStatus.success:
            return _buildSuccessState(context, state);
        }
      },
    );
  }

  Widget _buildLoadingState() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  Widget _buildFailureState(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const WinMeetBodyLarge(
              text: 'Something Went Wrong',
            ),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  child: ElevatedButton.icon(
                    label: const Text('Retry'),
                    icon: const Icon(Icons.refresh),
                    onPressed: () => context.read<ScheduleCubit>().getAllMeetings(),
                  ),
                ),
                const Spacer()
              ],
            ),
          ].withSpaceBetween(height: context.highValue),
        ),
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context, ScheduleState state) {
    final selectedDayEvents = context.read<ScheduleCubit>().getByDay(state.focusedDay);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.router.push(CreateMeetingRoute(cubit: context.read<ScheduleCubit>())),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildCalendarSection(context),
            if (selectedDayEvents.isEmpty)
              _EmptyState(focusedDay: state.focusedDay)
            else
              _EventList(focusedDay: state.focusedDay, events: selectedDayEvents),
          ].withSpaceBetween(height: context.mediumValue),
        ),
      ),
    );
  }

  Widget _buildCalendarSection(BuildContext context) {
    return WinMeetCalendar(
      focusedDay: context.read<ScheduleCubit>().state.focusedDay,
      eventLoader: (day) => context.read<ScheduleCubit>().getByDay(day),
      onFocusedDayChanged: (day) => context.read<ScheduleCubit>().updateFocusedDay(day),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.focusedDay});
  final DateTime focusedDay;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.paddingHorizontalDefault,
            child: WinMeetTitleLarge(text: DateFormatUtils.getDayMonthDay(focusedDay)),
          ),
          const Spacer(),
          const Center(
            child: WinMeetBodyLarge(
              text: 'No Meetings Scheduled',
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _EventList extends StatelessWidget {
  const _EventList({required this.focusedDay, required this.events});
  final DateTime focusedDay;
  final List<EventModel> events;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: context.paddingHorizontalDefault,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WinMeetTitleLarge(text: DateFormatUtils.getDayMonthDay(focusedDay)),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: context.mediumValue),
                itemCount: events.length,
                itemBuilder: (context, index) => _EventCard(event: events[index]),
              ),
            ),
          ].withSpaceBetween(height: context.mediumValue),
        ),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event});
  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: context.paddingAllLow,
        onTap: () {
          showModalBottomSheet<dynamic>(
            context: context,
            isScrollControlled: true,
            builder: (bottomSheetContext) => BlocProvider.value(
              value: context.read<ScheduleCubit>(),
              child: BlocListener<ScheduleCubit, ScheduleState>(
                listener: (context, state) {
                  if (state.status == PageStatus.success) {
                    context.router.pop();
                  }
                  if (state.status == PageStatus.failure) {
                    SnackbarUtils.showSnackbar(context: context, message: 'An error occurred while deleting meeting');
                    context.router.pop();
                  }
                },
                child: _MeetingDetails(event: event),
              ),
            ),
          );
        },
        title: WinMeetBodyLarge(text: event.eventName),
        subtitle: Text(event.eventDescription, maxLines: 1),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(DateFormatUtils.get12HourFormat(event.eventStartDate)),
            Text(DateFormatUtils.get12HourFormat(event.eventEndDate)),
          ],
        ),
      ),
    );
  }
}

class _MeetingDetails extends StatelessWidget {
  const _MeetingDetails({required this.event});

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingAllDefault,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: SizedBox(
              width: context.dynamicWidth(0.2),
              child: const Divider(),
            ),
          ),
          WinMeetTitleLarge(text: event.eventName),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WinMeetTitleMedium(text: 'Scheduled By'),
              Text(
                event.eventOwner,
              ),
            ],
          ),
          if (event.eventDescription.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WinMeetTitleMedium(text: 'Description'),
                Text(event.eventDescription),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WinMeetTitleMedium(text: 'When'),
              Text(
                '${DateFormatUtils.getMonthDayYearHour(event.eventStartDate)} - ${DateFormatUtils.getMonthDayYearHour(event.eventEndDate)}',
              ),
            ],
          ),
          if (event.location.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WinMeetTitleMedium(text: 'Location'),
                Text(event.location),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WinMeetTitleMedium(text: 'Participants'),
              SizedBox(
                height: context.highValue,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: event.participants.length,
                  separatorBuilder: (context, index) => SizedBox(width: context.lowValue),
                  itemBuilder: (context, participantsIndex) => Text(event.participants[participantsIndex]),
                ),
              )
            ],
          ),
          if (context.read<ScheduleCubit>().isOwner(email: event.eventOwner))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () => context.read<ScheduleCubit>().deleteMeeting(event.id),
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                ),
                TextButton.icon(
                  onPressed: () => context.router.push(
                    AddParticipantsRoute(
                      meetingId: event.id,
                      scheduleCubit: context.read<ScheduleCubit>(),
                      participants: ListFormInput.fromStringList(event.participants),
                      canRemoveParticipant: false,
                    ),
                  ),
                  icon: const Icon(Icons.person_add),
                  label: const Text('Add Participants'),
                ),
              ],
            ),
        ].withSpaceBetween(height: context.mediumValue),
      ),
    );
  }
}
