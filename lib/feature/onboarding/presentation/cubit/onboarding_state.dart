part of 'onboarding_cubit.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(false) bool isCompleted,
    @Default(0) int currentIndex,
  }) = _OnboardingState;

  const OnboardingState._();

  factory OnboardingState.initial() => const OnboardingState(isCompleted: false);

  factory OnboardingState.fromMap(Map<String, dynamic> map) {
    return OnboardingState(isCompleted: map['isCompleted'] as bool);
  }

  Map<String, dynamic> toMap() {
    return {'isCompleted': isCompleted};
  }
}
