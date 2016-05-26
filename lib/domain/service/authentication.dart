import 'dart:async';

import 'package:angular2/core.dart';
import 'package:ng2_g_signin/ng2_g_signin.dart' as google_auth;
import 'package:npb_polls/domain/service/logger.dart';
import 'package:npb_polls/resource/user/current_user_resource.dart';
import 'package:npb_polls/resource/user/google_users_resource.dart';
import 'package:stream_transformers/stream_transformers.dart' show Debounce;

import './../model/user.dart';

export './../model/user.dart';

const authentication = const Provider(Authentication,
    deps: const [GoogleUsersResource, CurrentUserResource]);

@Injectable()
class Authentication {
  User _currentUser;
  final GoogleUsersResource _googleUsersResource;
  final CurrentUserResource _currentUserResource;
  final Logger _logger;
  final StreamController _checkStreamController = new StreamController();
  StreamSubscription _checkSubscription;

  Authentication(
      this._googleUsersResource, this._currentUserResource, this._logger) {
    _checkSubscription = _checkStreamController.stream
        .transform(new Debounce(const Duration(milliseconds: 500)))
        .listen((_) {});
  }

  User get currentUser => _currentUser ??= guestUser;

  bool get isCurrentUserAuthenticated => currentUser is AuthenticatedUser;

  /// Google sign in backend authentication.
  Future authenticateWithGoogle(google_auth.GoogleSignInSuccess event) async {
    _logger.fine(
        'Authentication: Starting google sign in backend authentication.');
    google_auth.GoogleUser googleUser = event.googleUser;
    google_auth.AuthResponse authResponse = googleUser.getAuthResponse();
    google_auth.BasicProfile profile = googleUser.getBasicProfile();

    _currentUser = (await _googleUsersResource.post(authResponse.id_token,
            profile.getEmail(), profile.getName(), profile.getId()))
        .body;
  }

  Future<bool> check() {
    // A messy transient impl to avoid double fetching on the app launching.
    var completer = new Completer();
    if (isCurrentUserAuthenticated) {
      _logger.fine(
          'Authentication: CurrentUser is authenticated without fetching.');
      completer.complete(true);
    } else {
      _checkSubscription.onData((_check) => completer.complete(_check()));
      _checkStreamController.add(_check);
    }
    return completer.future;
  }

  Future<bool> _check() async {
    _logger.fine('Authentication: Fetching currentUser.');
    _currentUser = (await _currentUserResource.get()).body;
    return isCurrentUserAuthenticated;
  }
}
