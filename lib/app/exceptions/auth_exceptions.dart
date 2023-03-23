class RegisterWithEmailAndPasswordFailure implements Exception {
  const RegisterWithEmailAndPasswordFailure([this.message = 'An error occured while creating user.']);

  final String message;
}

class LoginWithEmailAndPasswordFailure implements Exception {
  const LoginWithEmailAndPasswordFailure([this.message = 'An error occured while login.']);

  final String message;
}

class PasswordResetFailure implements Exception {
  const PasswordResetFailure([this.message = 'An error occured while sending the password reset email.']);

  final String message;
}

class LogOutFailure implements Exception {
  const LogOutFailure([this.message = 'An error occured while logout.']);

  final String message;
}

class CreateMeetingFailure implements Exception {
  const CreateMeetingFailure([this.message = 'An error occured while creating meeting.']);

  final String message;
}
