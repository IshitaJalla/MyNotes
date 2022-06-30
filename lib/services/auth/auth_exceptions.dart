//LOGIN VIEW EXCEPTIONS
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

//REGISTER VIEW EXCEPTIONS
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

//GENERIC EXCEPTIONS IN ALL
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {
}  //after reg user null so we need to handle that
