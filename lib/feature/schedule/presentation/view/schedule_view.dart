import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:winmeet_mobile/app/router/app_router.gr.dart';
import 'package:winmeet_mobile/app/widgets/calendar/winmeet_calendar.dart';
import 'package:winmeet_mobile/core/enums/page_status.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/extensions/widget_extesions.dart';
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
                onPressed: () => context.router.push(const CreateMeetingRoute()),
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
                        Center(
                          child: SizedBox(
                            width: context.dynamicWidth(.2),
                            child: Divider(
                              color: context.theme.disabledColor,
                              thickness: 4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (selectedDayEvents.isEmpty)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: context.paddingAllLow,
                              child: Text(
                                DateFormat('EEEE, MMMM d').format(state.focusedDay),
                                style: context.textTheme.titleLarge,
                              ),
                            ),
                            const Spacer(),
                            Center(
                              child: Text(
                                'No Meeting Scheduled',
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
                              Text(
                                DateFormat('EEEE, MMMM d').format(state.focusedDay),
                                style: context.textTheme.titleLarge,
                              ),
                              Expanded(
                                child: ListView.separated(
                                  separatorBuilder: (context, index) => SizedBox(
                                    height: context.mediumValue,
                                  ),
                                  itemCount: selectedDayEvents.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        contentPadding: context.paddingAllLow,
                                        onTap: () {},
                                        title: Text(selectedDayEvents[index].eventName ?? ''),
                                        subtitle: Text(
                                          selectedDayEvents[index].description ?? '',
                                          maxLines: 1,
                                        ),
                                        trailing: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              selectedDayEvents[index].eventStartDate == null
                                                  ? 'Unknown'
                                                  : DateFormat('h:mm a')
                                                      .format(selectedDayEvents[index].eventStartDate!),
                                            ),
                                            Text(
                                              selectedDayEvents[index].eventEndDate == null
                                                  ? 'Unknown'
                                                  : DateFormat('h:mm a').format(selectedDayEvents[index].eventEndDate!),
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
