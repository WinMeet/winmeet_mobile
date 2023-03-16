part of 'theme_cubit.dart';

@freezed
class ThemeState with _$ThemeState {
  factory ThemeState({
    @Default(ThemeMode.system) ThemeMode theme,
    ThemeMode? settingsValue,
  }) = _ThemeState;

  const ThemeState._();

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(theme: ThemeMode.values[map['theme'] as int]);
  }
  Map<String, dynamic> toMap() {
    return {'theme': theme.index};
  }
}
