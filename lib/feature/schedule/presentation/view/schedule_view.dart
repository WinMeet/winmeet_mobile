import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:winmeet_mobile/app/router/app_router.gr.dart';
import 'package:winmeet_mobile/app/widgets/calendar/winmeet_calendar.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.router.push(const CreateMeetingRoute()),
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WinMeetCalendar(),
          Center(
            child: SizedBox(
              width: context.dynamicWidth(.2),
              child: Divider(
                color: context.theme.disabledColor,
                thickness: 4,
              ),
            ),
          ),
          Padding(
            padding: context.paddingAllDefault,
            child: Column(
              children: const [
                Text('DATA'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
