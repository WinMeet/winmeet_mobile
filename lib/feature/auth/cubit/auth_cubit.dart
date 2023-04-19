import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:winmeet_mobile/app/constants/cache_contants.dart';
import 'package:winmeet_mobile/core/cache/cache_client.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required CacheClient cacheClient})
      : _cacheClient = cacheClient,
        super(const AuthState.unauthenticated());

  final CacheClient _cacheClient;

  Future<void> checkAuthState() async {
    final token = _cacheClient.getString(CacheConstants.token);
    if (token != null && !Jwt.isExpired(token)) {
      emit(const AuthState.authenticated());
    } else {
      await _cacheClient.deleteKey(CacheConstants.token);
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> logout() async {
    await _cacheClient.deleteKey(CacheConstants.token);
    emit(const AuthState.unauthenticated());
  }
}
