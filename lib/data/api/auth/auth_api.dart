class AuthApi {
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );
  }

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );
  }

  Future<void> signOut() async {
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );
  }
}
