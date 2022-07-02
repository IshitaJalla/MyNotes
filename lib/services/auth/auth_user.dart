import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable //this class and its subclasses are immutable that is its internals will never be changed
class AuthUser {
  final String?
      email; //added this so that we make sure that user exists in the db as well
  final bool isEmailVerified;
  const AuthUser({
    required this.email,
    required this.isEmailVerified,
  }); //constructor

  factory AuthUser.fromFirebase(User user) => AuthUser(
        email: user.email,
        isEmailVerified: user.emailVerified,
      );
  //made a copy of the firebase user in our own authuser. this value will pass in the above constructor
  //by this we arenot exposing the firebase user to the UI and instead making an own authservice
}
