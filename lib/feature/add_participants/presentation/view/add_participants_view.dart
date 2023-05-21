import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:winmeet_mobile/app/widgets/input/email_input_field.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_body_large.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/extensions/widget_extesions.dart';
import 'package:winmeet_mobile/core/utils/snackbar/snackbar_utils.dart';
import 'package:winmeet_mobile/feature/add_participants/presentation/cubit/add_participants_cubit.dart';
import 'package:winmeet_mobile/feature/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:winmeet_mobile/injection.dart';

class AddParticipantsView extends StatefulWidget {
  const AddParticipantsView({
    required this.participants,
    this.meetingId,
    this.scheduleCubit,
    this.canRemoveParticipant = true,
    super.key,
  });
  final String? meetingId;
  final ScheduleCubit? scheduleCubit;
  final ListFormInput<String> participants;
  final bool canRemoveParticipant;

  @override
  State<AddParticipantsView> createState() => _AddParticipantsViewState();
}

class _AddParticipantsViewState extends State<AddParticipantsView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddParticipantsCubit>()
        ..initializeParticipants(
          participants: widget.participants,
          canRemoveParticipants: widget.canRemoveParticipant,
        ),
      child: _AddParticipantBody(
        controller: _controller,
        id: widget.meetingId,
        scheduleCubit: widget.scheduleCubit,
        canRemoveParticipants: widget.canRemoveParticipant,
      ),
    );
  }
}

class _AddParticipantBody extends StatelessWidget {
  const _AddParticipantBody({
    required TextEditingController controller,
    required String? id,
    required ScheduleCubit? scheduleCubit,
    required bool canRemoveParticipants,
  })  : _controller = controller,
        _id = id,
        _scheduleCubit = scheduleCubit,
        _canRemoveParticipants = canRemoveParticipants;

  final TextEditingController _controller;
  final String? _id;
  final ScheduleCubit? _scheduleCubit;
  final bool _canRemoveParticipants;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddParticipantsCubit, AddParticipantsState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          _scheduleCubit!.getAllMeetings().then(
                (_) => context.router.pop().then(
                      (_) => SnackbarUtils.showSnackbar(
                        context: context,
                        message: 'Invitation email has been sent to new participants',
                      ),
                    ),
              );
        } else if (state.status.isSubmissionFailure) {
          SnackbarUtils.showSnackbar(
            context: context,
            message: 'An error occured while adding participants',
          );
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          context.router.popForced(context.read<AddParticipantsCubit>().state.participants);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Participants'),
            actions: _canRemoveParticipants
                ? []
                : [
                    BlocBuilder<AddParticipantsCubit, AddParticipantsState>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: state.status.isValid || state.status.isSubmissionFailure
                              ? () => context.read<AddParticipantsCubit>().updateMeetingParticipants(
                                    id: _id!,
                                    participants: context.read<AddParticipantsCubit>().state.participants.value,
                                  )
                              : null,
                          icon: state.status.isSubmissionInProgress
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : const Icon(Icons.done),
                        );
                      },
                    )
                  ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: context.paddingAllDefault,
                child: Column(
                  children: [
                    _EmailInput(controller: _controller),
                    _SearchResult(controller: _controller),
                    const _ParticipantList(),
                  ].withSpaceBetween(height: context.mediumValue),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({required TextEditingController controller}) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddParticipantsCubit, AddParticipantsState>(
      buildWhen: (previous, current) => previous.email.value != current.email.value,
      builder: (context, state) {
        return EmailInputField(
          controller: _controller,
          textInputAction: TextInputAction.search,
          autoFocus: true,
          labelText: 'Enter an email address',
          onChanged: (email) => context.read<AddParticipantsCubit>().emailChanged(email: email),
        );
      },
    );
  }
}

class _SearchResult extends StatelessWidget {
  const _SearchResult({required TextEditingController controller}) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddParticipantsCubit, AddParticipantsState>(
      builder: (context, state) {
        if (state.email.valid) {
          return Card(
            child: _AddParticipantListTile(
              title: state.email.value,
              trailing: const IconButton(
                icon: Icon(Icons.add),
                onPressed: null,
              ),
              onTap: () => context.read<AddParticipantsCubit>().addParticipantToParticipants(email: state.email.value)
                  ? _controller.clear()
                  : null,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _ParticipantList extends StatelessWidget {
  const _ParticipantList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddParticipantsCubit, AddParticipantsState>(
      builder: (context, state) {
        if (state.participants.value.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WinMeetBodyLarge(
                text: 'Participants',
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(
                  height: context.mediumValue,
                ),
                itemCount: state.participants.value.length,
                itemBuilder: (context, index) {
                  final canBeRemoved =
                      context.read<AddParticipantsCubit>().canBeRemoved(email: state.participants.value[index]);
                  return Card(
                    child: _AddParticipantListTile(
                      title: state.participants.value[index],
                      trailing: IconButton(
                        icon: canBeRemoved ? const Icon(Icons.close) : const SizedBox.shrink(),
                        onPressed: canBeRemoved
                            ? () => context.read<AddParticipantsCubit>().removeParticipantFromParticipants(
                                  email: state.participants.value[index],
                                )
                            : null,
                      ),
                    ),
                  );
                },
              )
            ].withSpaceBetween(height: context.mediumValue),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _AddParticipantListTile extends StatelessWidget {
  const _AddParticipantListTile({required this.title, this.trailing, this.onTap});

  final String title;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: context.paddingAllLow,
      title: WinMeetBodyLarge(text: title),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
