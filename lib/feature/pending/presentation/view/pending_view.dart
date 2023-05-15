import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                          final eventDates = state.events[index].getEventStartDates();
                          return Card(
                            child: Padding(
                              padding: context.paddingAllLow,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  WinMeetTitleLarge(
                                    text: state.events[index].eventName,
                                  ),
                                  ListView.separated(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) => SizedBox(
                                      height: context.lowValue,
                                    ),
                                    itemCount: eventDates.length,
                                    itemBuilder: (context, dateIndex) => Column(
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
                                                  'Ends: ${DateFormatUtils.getMonthDayYearHour(eventDates[dateIndex].eventEndDate)}',
                                                ),
                                                Text(
                                                  'Starts: ${DateFormatUtils.getMonthDayYearHour(eventDates[dateIndex].eventStartDate)}',
                                                ),
                                              ],
                                            ),
                                            TextButton.icon(
                                              onPressed: () async {
                                                await context.read<PendingCubit>().voteMeetingDate(
                                                      eventId: state.events[index].id,
                                                      dateIndex: eventDates[index].index,
                                                    );
                                              },
                                              label: const Text('Vote'),
                                              icon: const Icon(Icons.check),
                                            ),
                                          ],
                                        ),
                                      ].withSpaceBetween(
                                        height: context.lowValue,
                                      ),
                                    ),
                                  ),
                                ].withSpaceBetween(
                                  height: context.lowValue,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                ],
              ),
            );

          case PageStatus.failure:
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
      },
    );
  }
}
