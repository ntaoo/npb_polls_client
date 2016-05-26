import 'dart:async';
import 'user.dart';
export 'dart:async';

abstract class AuthenticatedUser extends User {
  bool get isNewUser => false;

  Future signOut();
}
