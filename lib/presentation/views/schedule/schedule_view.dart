import 'package:flutter/material.dart';

import '../../widgets/calendar/custom_table_calendar.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: const [
          CustomTableCalendar(),
          Expanded(
            child: Center(
              child: Text(
                "No Meetings Scheduled",
              ),
            ),
          )
        ],
      ),
    );
  }
}
