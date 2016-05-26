import 'package:ng2_g_signin/src/google_signin_js/gapi/auth2.dart' as auth2
    show getAuthInstance;
import 'authenticated_user.dart';

class GoogleUser extends AuthenticatedUser {
  /// The id is NOT a google user id.
  ///
  /// This is issued by the backend server first time a google user is being authenticated.
  final String id;
  final String googleUserId;
  final String name;
  final String email;
  final bool isNewUser;

  GoogleUser(this.id, this.googleUserId, this.name, this.email,
      {this.isNewUser: false});

  Future signOut() {
    return new Future.sync(() => auth2.getAuthInstance().signOut());
  }
}
