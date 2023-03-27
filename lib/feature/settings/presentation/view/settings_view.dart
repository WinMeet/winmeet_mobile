// ignore_for_file: inference_failure_on_function_invocation

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winmeet_mobile/app/theme/cubit/theme_cubit.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/extensions/widget_extesions.dart';

import 'package:winmeet_mobile/feature/auth/cubit/auth_cubit.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: context.paddingAllDefault,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Display',
              style: context.textTheme.titleLarge,
            ),
            ListTile(
              leading: const Icon(Icons.brightness_medium),
              title: const Text('Theme'),
              onTap: () => showDialog(context: context, builder: (context) => const _ThemeDialog()),
            ),
            Text(
              'Account',
              style: context.textTheme.titleLarge,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
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
                Text(
                  'Choose Theme',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('System Default'),
                  value: ThemeMode.system,
                  groupValue: state.settingsValue ?? state.theme,
                  onChanged: (ThemeMode? theme) => context.read<ThemeCubit>().modifyTheme(theme!),
                ),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Light'),
                  value: ThemeMode.light,
                  groupValue: state.settingsValue ?? state.theme,
                  onChanged: (ThemeMode? theme) => context.read<ThemeCubit>().modifyTheme(theme!),
                ),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Dark'),
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
            Text(
              'Logout',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(
              height: context.mediumValue,
            ),
            const Text(
              'Are you sure you want to logout?',
            ),
            SizedBox(
              height: context.mediumValue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => context.router.pop(),
                  child: const Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () => context.read<AuthCubit>().logout(),
                  child: const Text('OK'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
