import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:ng2_g_signin/ng2_g_signin.dart' as auth;
import 'package:npb_polls/domain/service/authentication.dart';

@Component(
    selector: 'sign-in',
    templateUrl: 'sign_in_component.html',
    styleUrls: const ['sign_in_component.css'],
    directives: const [auth.GSignin])
class SignInComponent {
  Authentication _authentication;
  Router _router;

  SignInComponent(this._authentication, this._router);

  /// After the google sign in button is rendered, the google sign in process
  /// always runs automatically without clicking the button when a google user
  /// account has been authorized and connected.
  /// Perhaps no public API to disable the automatic sign in but GoogleAuth signOut().
  /// Also needs to revoke the session when the google auth has been revoked.
  Future onGoogleSigninSuccess(auth.GoogleSignInSuccess event) async {
    await _authentication.authenticateWithGoogle(event);
    GoogleUser googleUser = _authentication.currentUser;
    if (googleUser.isNewUser) _router.navigate(['Polls']);
  }
}
