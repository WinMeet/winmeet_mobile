// ignore_for_file: inference_failure_on_function_invocation

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winmeet_mobile/app/cubit/app_cubit.dart';
import 'package:winmeet_mobile/app/theme/cubit/theme_cubit.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_body_large.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_title_large.dart';
import 'package:winmeet_mobile/app/widgets/text/winmeet_title_medium.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/extensions/widget_extesions.dart';
import 'package:winmeet_mobile/feature/settings/data/repository/settings_repository.dart';
import 'package:winmeet_mobile/injection.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: RepositoryProvider(
        create: (context) => getIt<SettingsRepository>(),
        child: const _SettingsViewBody(),
      ),
    );
  }
}

class _SettingsViewBody extends StatelessWidget {
  const _SettingsViewBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: context.paddingAllDefault,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: context.highValue,
                    child: WinMeetTitleLarge(
                      text: context.read<SettingsRepository>().getInitialsFromUserToken(),
                    ),
                  ),
                  WinMeetBodyLarge(
                    text: context.read<SettingsRepository>().getNameSurnameFromUserToken(),
                  ),
                  Text(
                    context.read<SettingsRepository>().getEmailFromUserToken(),
                  )
                ].withSpaceBetween(height: context.lowValue),
              ),
            ),
            const WinMeetTitleLarge(text: 'Display'),
            ListTile(
              leading: const Icon(Icons.brightness_medium),
              title: const WinMeetBodyLarge(text: 'Theme'),
              onTap: () => showDialog(context: context, builder: (context) => const _ThemeDialog()),
            ),
            const WinMeetTitleLarge(text: 'Account'),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const WinMeetBodyLarge(text: 'Logout'),
              onTap: () => showDialog(context: context, builder: (context) => const _LogoutDialog()),
            )
          ].withSpaceBetween(height: context.lowValue),
        ),
      ),
    );
  }
}

class _ThemeDialog extends StatelessWidget {
  const _ThemeDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: context.paddingAllDefault,
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const WinMeetTitleMedium(
                  text: 'Choose Theme',
                ),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const WinMeetBodyLarge(text: 'System Default'),
                  value: ThemeMode.system,
                  groupValue: state.settingsValue ?? state.theme,
                  onChanged: (ThemeMode? theme) => context.read<ThemeCubit>().modifyTheme(theme!),
                ),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const WinMeetBodyLarge(text: 'Light'),
                  value: ThemeMode.light,
                  groupValue: state.settingsValue ?? state.theme,
                  onChanged: (ThemeMode? theme) => context.read<ThemeCubit>().modifyTheme(theme!),
                ),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const WinMeetBodyLarge(text: 'Dark'),
                  value: ThemeMode.dark,
                  groupValue: state.settingsValue ?? state.theme,
                  onChanged: (ThemeMode? theme) => context.read<ThemeCubit>().modifyTheme(theme!),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => context.router.pop(),
                      child: const Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<ThemeCubit>().changeTheme();
                        context.router.pop();
                      },
                      child: const Text('OK'),
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LogoutDialog extends StatelessWidget {
  const _LogoutDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: context.paddingAllDefault,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const WinMeetTitleMedium(
              text: 'Logout',
            ),
            const Text(
              'Are you sure you want to logout?',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => context.router.pop(),
                  child: const Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () => context.read<AppCubit>().logout(),
                  child: const Text('OK'),
                )
              ],
            ),
          ].withSpaceBetween(height: context.mediumValue),
        ),
      ),
    );
  }
}
