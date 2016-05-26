import 'dart:async';
import 'package:angular2/core.dart';
import 'package:npb_polls/domain/model/standings.dart';
import 'package:npb_polls/domain/model/leagues.dart';

import '../src/http_lift/lift_client.dart';
import '../src/end_points.dart';

export '../src/http_lift/lift_client.dart' show Response;

@Injectable()
class StandingsVotesResource {
  final LiftClient _client;

  StandingsVotesResource(this._client);

  Future<Response<List<Standings>>> list() async {
    Response response = await _client.get(EndPoints.standingsVotes);
    if (response.statusCode == HttpStatus.OK) {
      response.body = response.body.map(_toEntity).toList();
    }
    return response;
  }

  Future<Response<Standings>> post(Standings standingsVote) async {
    Response response = await _client.post(
        EndPoints.standingsVotes, _toJsonEncodableMap(standingsVote));

    if (response.statusCode == HttpStatus.CREATED) {
      response.body = _toEntity(response.body);
    }
    return response;
  }

  Map _toJsonEncodableMap(Standings standingsVote) {
    return {
      'leagueId': standingsVote.league.id,
      'standings': standingsVote
          .map((s) => {'number': s.number, 'teamId': s.team.id})
          .toList()
    };
  }

  Standings _toEntity(Map data) {
    var league = leagues.getById(data['leagueId']);
    List<Standing> standings = data['standings']
        .map((Map standing) => new Standing(standing['number'],
            league.teams.firstWhere((t) => t.id == standing['teamId'])))
        .toList();

    return new Standings(
        league, standings, DateTime.parse(data['createdTime']));
  }
}
