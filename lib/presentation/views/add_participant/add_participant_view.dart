import 'package:flutter/material.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../widgets/input/text_input_field.dart';
import 'participants.dart';

class AddParticipantView extends StatefulWidget {
  const AddParticipantView({super.key});

  @override
  State<AddParticipantView> createState() => _AddParticipantViewState();
}

class _AddParticipantViewState extends State<AddParticipantView> {
  List<SearchModel> matches = [];
  List<SearchModel> participants = [];
  void searchAllUsers(String term) {
    if (term.length > 2) {
      final suggestions = allUsers.where((user) {
        return user.email.toLowerCase().contains(term.toLowerCase());
      }).toList();
      setState(() {
        matches = suggestions;
      });
    }
    if (term.isEmpty) {
      setState(() {
        matches = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Participants'),
      ),
      body: Padding(
        padding: context.paddingAllDefault,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInputField(
              labelText: 'Search or enter an email address',
              onChanged: (term) => searchAllUsers(term),
            ),
            SizedBox(
              height: context.mediumValue,
            ),
            if (matches.isNotEmpty)
              Text(
                'Matches: ',
                style: context.textTheme.bodyMedium,
              ),
            ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: context.lowValue,
                );
              },
              shrinkWrap: true,
              itemCount: matches.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    title: Text(matches[index].email),
                    trailing: const Icon(Icons.add),
                    onTap: () {
                      if (!participants.contains(matches[index])) {
                        participants.add(matches[index]);
                      }
                      setState(() {});
                    },
                  ),
                );
              },
            ),
            if (participants.isNotEmpty)
              SizedBox(
                height: context.mediumValue,
              ),
            if (participants.isNotEmpty)
              Text(
                'Participants:',
                style: context.textTheme.bodyMedium,
              ),
            Expanded(
                child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: context.lowValue,
                );
              },
              itemCount: participants.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    title: Text(participants[index].email),
                    trailing: const Icon(Icons.cancel),
                    onTap: () {
                      participants.remove(participants[index]);
                      setState(() {});
                    },
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
