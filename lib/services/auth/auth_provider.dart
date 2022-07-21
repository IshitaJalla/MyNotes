import 'package:learningdart/services/auth/auth_user.dart';
// this will consist of every provider that oru application might need

abstract class AuthProvider {
  //protocol no logic here

  Future<void> initialize();
  AuthUser? get currentUser;
  //any auth provider ggogle,fb,email, it needs to be able to optionally return the currenty authenticated user

  //creating a function for user to login
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  //crating a function for user to signup/reg or create a new user
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  //creating a function for the user to log out
  Future<void> logOut();
  //func for email verf
  Future<void> sendEmailVerification();

  Future<void> sendPasswordReset({required String toEmail});
}
