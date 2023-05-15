
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:winmeet_mobile/app/utils/calendar/calendar_utils.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_body_large.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_title_large.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_title_medium.dart';
import 'package:winmeet_mobile/core/enums/page_status.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/extensions/widget_extesions.dart';
import 'package:winmeet_mobile/core/utils/date_format/date_format_utils.dart';
import 'package:winmeet_mobile/feature/pending/presentation/cubit/pending_cubit.dart';
import 'package:winmeet_mobile/injection.dart';

class PendingView extends StatelessWidget {
  const PendingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending'),
      ),
      body: BlocProvider(
        create: (context) => getIt<PendingCubit>()..getPendingMeetings(),
        child: const _PendingViewBody(),
      ),
    );
  }
}

class _PendingViewBody extends StatelessWidget {
  const _PendingViewBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PendingCubit, PendingState>(
      builder: (context, state) {
        switch (state.status) {
          case PageStatus.initial:
          case PageStatus.loading:
            return const CircularProgressIndicator.adaptive();
          case PageStatus.success:
            return _SuccessWidget(state: state);
          case PageStatus.failure:
            return const _FailureWidget();
        }
      },
    );
  }
}

class _SuccessWidget extends StatelessWidget {
  const _SuccessWidget({required this.state});

  final PendingState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingAllDefault,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (state.events.isEmpty)
            const Center(
              child: WinMeetBodyLarge(
                text: 'No Meetings Pending',
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: context.mediumValue,
                ),
                itemCount: state.events.length,
                itemBuilder: (context, index) {
                  return _EventDetailsWidget(state: state, index: index);
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _EventDetailsWidget extends StatelessWidget {
  const _EventDetailsWidget({required this.state, required this.index});

  final PendingState state;
  final int index;

  @override
  Widget build(BuildContext context) {
    final eventDates = state.events[index].getEventStartDates();
    return Card(
      child: Padding(
        padding: context.paddingAllLow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WinMeetTitleLarge(
                  text: state.events[index].eventName,
                ),
                if (state.events[index].voteDueDate.isAtSameMomentAs(CalendarUtils.today) ||
                    state.events[index].voteDueDate.isAfter(CalendarUtils.today))
                  Text(
                    'Ends in ${timeago.format(state.events[index].voteDueDate, allowFromNow: true, locale: 'en_short')}',
                  )
              ],
            ),
            SizedBox(
              height: context.lowValue,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: eventDates.length,
              itemBuilder: (context, dateIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WinMeetTitleMedium(text: 'Date ${dateIndex + 1}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Starts: ${DateFormatUtils.getMonthDayYearHour(eventDates[dateIndex].eventStartDate)}',
                            ),
                            Text(
                              'Ends: ${DateFormatUtils.getMonthDayYearHour(eventDates[dateIndex].eventEndDate)}',
                            ),
                          ],
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            await context.read<PendingCubit>().voteMeetingDate(
                                  eventId: state.events[index].id,
                                  dateIndex: eventDates[dateIndex].index,
                                );
                          },
                          label: const Text('Vote'),
                          icon: const Icon(Icons.check),
                        )
                      ],
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class _FailureWidget extends StatelessWidget {
  const _FailureWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingAllDefault,
      child: Column(
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
                  onPressed: () => context.read<PendingCubit>().getPendingMeetings(),
                ),
              ),
              const Spacer()
            ],
          ),
        ].withSpaceBetween(height: context.highValue),
      ),
    );
  }
}
