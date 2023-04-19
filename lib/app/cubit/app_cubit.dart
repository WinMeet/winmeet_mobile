import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:winmeet_mobile/app/constants/cache_contants.dart';
import 'package:winmeet_mobile/core/cache/cache_client.dart';

part 'app_state.dart';
part 'app_cubit.freezed.dart';

@injectable
class AppCubit extends Cubit<AppState> {
  AppCubit({required CacheClient cacheClient})
      : _cacheClient = cacheClient,
        super(const AppState.unauthenticated());

  final CacheClient _cacheClient;

  Future<void> checkAppState() async {
    final isOnboardingCompleted = _cacheClient.getBool(CacheConstants.isOnboardingCompleted);

    if (isOnboardingCompleted ?? false) {
      final token = _cacheClient.getString(CacheConstants.token);
      if (token != null && !Jwt.isExpired(token)) {
        emit(const AppState.authenticated());
      } else {
        await _cacheClient.deleteKey(CacheConstants.token);
        emit(const AppState.unauthenticated());
      }
    } else {
      emit(const AppState.onboarding());
    }
  }

  Future<void> completeOnboarding() async {
    await _cacheClient.setBool(CacheConstants.isOnboardingCompleted, true);
    emit(const AppState.unauthenticated());
  }

  Future<void> logout() async {
    await _cacheClient.deleteKey(CacheConstants.token);
    emit(const AppState.unauthenticated());
  }
}
