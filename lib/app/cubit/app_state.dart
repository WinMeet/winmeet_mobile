part of 'app_cubit.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.onboarding() = _Onboarding;
  const factory AppState.unauthenticated() = _Unauthenticated;
  const factory AppState.authenticated() = _Authenticated;
}
