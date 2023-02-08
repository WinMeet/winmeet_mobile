part of 'theme_bloc.dart';

@freezed
class ThemeEvent with _$ThemeEvent {
  const factory ThemeEvent.themeChanged() = _ThemeChanged;
  const factory ThemeEvent.themeTileChanged({required ThemeMode settingsValue}) = _ThemeTileChanged;
}
