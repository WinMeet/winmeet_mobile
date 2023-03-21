// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:winmeet_mobile/app/router/app_router.gr.dart';
// import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
// import 'package:winmeet_mobile/core/utils/calendar/calendar_utils.dart';
// import 'package:winmeet_mobile/presentation/widgets/input/text_input_field.dart';

// class CreateMeetingView extends StatefulWidget {
//   const CreateMeetingView({super.key});

//   @override
//   State<CreateMeetingView> createState() => _CreateMeetingViewState();
// }

// class _CreateMeetingViewState extends State<CreateMeetingView> {
//   DateTime starts = DateTime.now().add(const Duration(hours: 1)).subtract(Duration(minutes: DateTime.now().minute));

//   DateTime ends = DateTime.now().add(const Duration(hours: 2)).subtract(Duration(minutes: DateTime.now().minute));

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Create Meeting',
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               if (_formKey.currentState!.validate()) {
//                 context.router.pop();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Emails are sent to all participants.'),
//                   ),
//                 );
//               }
//             },
//             icon: const Icon(
//               Icons.done,
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: context.paddingAllDefault,
//         child: Column(
//           children: [
//             Form(
//               key: _formKey,
//               child: TextInputField(
//                 errorText: 'This field cannot be empty',
//                 labelText: 'Meeting Title',
//                 textInputAction: TextInputAction.next,
//                 isValidInput: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Title cannot be empty';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//             SizedBox(
//               height: context.mediumValue,
//             ),
//             const TextInputField(
//               errorText: 'This field cannot be empty',
//               labelText: 'Meeting Description',
//               textInputAction: TextInputAction.done,
//               isValidInput: true,
//             ),
//             SizedBox(
//               height: context.mediumValue,
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.zero,
//               leading: const Text('Starts'),
//               onTap: () async {
//                 final date = await pickDate(context: context, initialTime: starts);

//                 if (date == null) return;

//                 final time = await pickTime(context: context, initialTime: date);
//                 if (time != null) {
//                   setState(() {
//                     starts = DateTime(date.year, date.month, date.day, time.hour, time.minute);
//                     ends = DateTime(date.year, date.month, date.day, time.hour + 1, time.minute);
//                   });
//                 }
//               },
//               trailing: Text(DateFormat.yMMMd().add_Hm().format(starts)),
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.zero,
//               leading: const Text('Ends'),
//               onTap: () async {
//                 final date = await pickDate(context: context, initialTime: ends);

//                 if (date == null) return;

//                 final time = await pickTime(context: context, initialTime: ends);
//                 if (time != null) {
//                   setState(() {
//                     ends = DateTime(date.year, date.month, date.day, time.hour, time.minute);
//                   });
//                 }
//               },
//               trailing: Text(DateFormat.yMMMd().add_Hm().format(ends)),
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.zero,
//               leading: const Text('Participants'),
//               onTap: () {
//                 context.router.push(
//                   const AddParticipantRoute(),
//                 );
//               },
//               trailing: const Icon(
//                 Icons.chevron_right,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<DateTime?> pickDateTime({
//     required BuildContext context,
//     required DateTime initialTime,
//   }) async {
//     final pickedDate = await pickDate(context: context, initialTime: initialTime);

//     if (context.mounted && pickedDate != null) {
//       final pickedTime = await pickTime(context: context, initialTime: initialTime);

//       if (pickedTime != null) {
//         return DateTime(
//           pickedDate.year,
//           pickedDate.month,
//           pickedDate.day,
//           pickedTime.hour,
//           pickedTime.minute,
//         );
//       }
//     }

//     return null;
//   }

//   Future<DateTime?> pickDate({required BuildContext context, required DateTime initialTime}) {
//     return showDatePicker(
//       initialEntryMode: DatePickerEntryMode.calendarOnly,
//       context: context,
//       initialDate: initialTime,
//       firstDate: CalendarUtils.kToday,
//       lastDate: CalendarUtils.kLastDay,
//     );
//   }

//   Future<TimeOfDay?> pickTime({required BuildContext context, required DateTime initialTime}) {
//     return showTimePicker(
//       initialEntryMode: TimePickerEntryMode.dialOnly,
//       context: context,
//       initialTime: TimeOfDay.fromDateTime(initialTime),
//     );
//   }
// }
