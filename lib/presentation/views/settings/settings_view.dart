import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/extensions/context_extensions.dart';

import '../../../app/theme/theme_bloc.dart';

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
              style: context.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w700),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.brightness_medium),
              title: const Text('Theme'),
              onTap: () => _settingsDialog(
                context: context,
                child: const _ThemeTileDialog(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeTileDialog extends StatelessWidget {
  const _ThemeTileDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: context.paddingAllDefault,
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose Theme',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('System Default'),
                  value: ThemeMode.system,
                  groupValue: state.settingsValue ?? state.theme,
                  onChanged: (ThemeMode? theme) => context.read<ThemeBloc>().add(ThemeTileChanged(theme!)),
                ),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Light'),
                  value: ThemeMode.light,
                  groupValue: state.settingsValue ?? state.theme,
                  onChanged: (ThemeMode? theme) => context.read<ThemeBloc>().add(ThemeTileChanged(theme!)),
                ),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Dark'),
                  value: ThemeMode.dark,
                  groupValue: state.settingsValue ?? state.theme,
                  onChanged: (ThemeMode? theme) => context.read<ThemeBloc>().add(ThemeTileChanged(theme!)),
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
                        context.read<ThemeBloc>().add(ThemeChanged());
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

Future<dynamic> _settingsDialog({required BuildContext context, required Widget child}) {
  return showDialog(
    context: context,
    builder: (_) {
      return BlocProvider.value(
        value: context.read<ThemeBloc>(),
        child: child,
      );
    },
  );
}
