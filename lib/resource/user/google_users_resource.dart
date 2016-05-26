import 'dart:async';

import 'package:angular2/core.dart';
import 'package:npb_polls/domain/model/user.dart' show GoogleUser;

import '../src/end_points.dart';
import '../src/http_lift/lift_client.dart';

export '../src/http_lift/lift_client.dart' show Response;

@Injectable()
class GoogleUsersResource {
  final LiftClient _client;

  GoogleUsersResource(this._client);

  Future<Response<GoogleUser>> post(
      String idToken, String email, String name, String googleUserId) async {
    Map sendData = {
      'idToken': idToken,
      'email': email,
      'name': name,
      'userId': googleUserId
    };
    Response response = await _client.post(EndPoints.googleUsers, sendData);
    if (response.statusCode == HttpStatus.OK ||
        response.statusCode == HttpStatus.CREATED) {
      response.body = _toEntity(response.body, response.statusCode);
    }
    return response;
  }

  GoogleUser _toEntity(Map data, int statusCode) => new GoogleUser(
      data['id'].toString(),
      data['googleUserId'].toString(),
      data['name'],
      data['email'],
      isNewUser: statusCode == HttpStatus.CREATED);
}
