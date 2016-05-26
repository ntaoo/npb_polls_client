import 'dart:async';

import 'package:angular2/core.dart';
import 'package:npb_polls/domain/model/user.dart';

import '../src/end_points.dart';
import '../src/http_lift/lift_client.dart';

export '../src/http_lift/lift_client.dart' show Response;

@Injectable()
class CurrentUserResource {
  final LiftClient _client;

  CurrentUserResource(this._client);

  Future<Response<User>> get() async {
    Response response = await _client.get(EndPoints.currentUser);
    return response..body = _toEntity(response.body);
  }

  User _toEntity(Map data) {
    User user;
    switch (data['authProvider']) {
      case 'google':
        user = new GoogleUser(data['id'].toString(),
            data['authUserId'].toString(), data['name'], data['email']);
        break;
      case 'own':
        if (data['id'] == guestUser.id) {
          user = guestUser;
        } else {
          throw new UnsupportedError('Unsupported ID');
        }
        break;
      default:
        throw new UnsupportedError(
            'The auth provider: ${data['authProvider']} is not supported for this app.');
    }
    return user;
  }
}
