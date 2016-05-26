import 'dart:async';

import 'package:angular2/core.dart';
import 'package:npb_polls/domain/model/standings_poll.dart';

import '../src/end_points.dart';
import '../src/http_lift/lift_client.dart';

@Injectable()
class StandingsPollsResource {
  final LiftClient _client;

  StandingsPollsResource(this._client);

  Future<Response<List<StandingsPoll>>> list() async {
    Response response = await _client.get(EndPoints.standingsPolls);
    if (response.statusCode == HttpStatus.OK) {
      response.body = response.body.map(_toEntity).toList();
    }
    return response;
  }

  StandingsPoll _toEntity(Map data) {
    League league = leagues.getById(data['leagueId']);

    List<StandingPoll> standings = data['standings'].map((standing) {
      List<Vote> votes = standing['votes']
          .map((vote) => new Vote(
              league.teams.firstWhere((team) => team.id == vote['teamId']),
              vote['number']))
          .toList();
      return new StandingPoll(standing['number'], votes);
    }).toList();
    return new StandingsPoll(league, standings);
  }
}
