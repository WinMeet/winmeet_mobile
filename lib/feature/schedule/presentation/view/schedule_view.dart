import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winmeet_mobile/app/router/app_router.gr.dart';
import 'package:winmeet_mobile/app/widgets/calendar/winmeet_calendar.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_title_large.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_title_medium.dart';
import 'package:winmeet_mobile/core/enums/page_status.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/extensions/widget_extesions.dart';
import 'package:winmeet_mobile/core/utils/date_format/date_format_utils.dart';
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
          case PageStatus.loading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );

          case PageStatus.failure:
            return const Scaffold(
              body: Center(
                child: Text('Failed'),
              ),
            );

          case PageStatus.success:
            final selectedDayEvents = context.read<ScheduleCubit>().getByDay(state.focusedDay);

            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => context.router.push(CreateMeetingRoute(cubit: context.read<ScheduleCubit>())),
                child: const Icon(Icons.add),
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Column(
                      children: [
                        WinMeetCalendar(
                          focusedDay: context.read<ScheduleCubit>().state.focusedDay,
                          eventLoader: (day) => context.read<ScheduleCubit>().getByDay(day),
                          onFocusedDayChanged: (day) => context.read<ScheduleCubit>().updateFocusedDay(day),
                        ),
                      ],
                    ),
                    if (selectedDayEvents.isEmpty)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: context.paddingHorizontalDefault,
                              child: WinMeetTitleLarge(text: DateFormatUtils.getDayMonthDay(state.focusedDay)),
                            ),
                            const Spacer(),
                            Center(
                              child: Text(
                                'No Meetings Scheduled',
                                style: context.textTheme.bodyLarge,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      )
                    else
                      Expanded(
                        child: Padding(
                          padding: context.paddingHorizontalDefault,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              WinMeetTitleLarge(text: DateFormatUtils.getDayMonthDay(state.focusedDay)),
                              Expanded(
                                child: ListView.separated(
                                  separatorBuilder: (context, index) => SizedBox(
                                    height: context.mediumValue,
                                  ),
                                  itemCount: selectedDayEvents.length,
                                  itemBuilder: (context, index) {
                                    final event = selectedDayEvents[index];
                                    return Card(
                                      child: ListTile(
                                        contentPadding: context.paddingAllLow,
                                        onTap: () {
                                          showModalBottomSheet<dynamic>(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (context) => _MeetingDetails(event: event),
                                          );
                                        },
                                        title: Text(selectedDayEvents[index].eventName),
                                        subtitle: Text(
                                          selectedDayEvents[index].eventDescription,
                                          maxLines: 1,
                                        ),
                                        trailing: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              DateFormatUtils.get12HourFormat(
                                                selectedDayEvents[index].eventStartDate,
                                              ),
                                            ),
                                            Text(
                                              DateFormatUtils.get12HourFormat(
                                                selectedDayEvents[index].eventEndDate,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ].withSpaceBetween(height: context.mediumValue),
                          ),
                        ),
                      ),
                  ].withSpaceBetween(height: context.mediumValue),
                ),
              ),
            );
        }
      },
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
          if (event.eventDescription.isNotEmpty) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WinMeetTitleMedium(text: 'Description'),
                Text(event.eventDescription),
              ],
            ),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WinMeetTitleMedium(text: 'When'),
              Text(
                '${DateFormatUtils.getMonthDayYearHour(event.eventStartDate)} - ${DateFormatUtils.getMonthDayYearHour(event.eventEndDate)}',
              ),
            ],
          ),
          if (event.location.isNotEmpty) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WinMeetTitleMedium(text: 'Location'),
                Text(event.location),
              ],
            ),
          ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),
            ],
          ),
        ].withSpaceBetween(height: context.mediumValue),
      ),
    );
  }
}
