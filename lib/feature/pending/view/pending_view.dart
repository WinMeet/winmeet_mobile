import 'package:flutter/material.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_title_large.dart';

class PendingView extends StatelessWidget {
  const PendingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: WinMeetTitleLarge(
              text: 'No Meetings Pending',
            ),
          ),
        ],
      ),
    );
  }
}
