import 'package:flutter/foundation.dart';
import 'package:learningdart/services/auth/auth_user.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

class AuthStateNeedsVerfication extends AuthState {
  const AuthStateNeedsVerfication();
}

class AuthStateLoggedOut extends AuthState {
  final Exception? exception;
  const AuthStateLoggedOut(this.exception);
}
//login failure is expressed qith logged out state

class AuthStateLogoutFailure extends AuthState {
  final Exception exception;
  const AuthStateLogoutFailure(this.exception);
}
