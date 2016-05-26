import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:npb_polls/component/shared/is_authenticated.dart';
import 'package:npb_polls/component/shared/snack_bar/snack_bar_event.dart';
import 'package:npb_polls/domain/model/leagues.dart' as l;
import 'package:npb_polls/domain/model/standings.dart';
import 'package:npb_polls/domain/model/standings_votes.dart';
import 'package:npb_polls/domain/service/authentication.dart';
import 'package:npb_polls/resource/vote/standings_votes_resource.dart';

import 'standings_vote_component/standings_vote_component.dart';
import 'standings_voting_form_component/standings_voting_form_component.dart';

@Component(
    selector: 'votes',
    templateUrl: 'votes_component.html',
    styleUrls: const ['votes_component.css'],
    directives: const [StandingsVotingFormComponent, StandingsVoteComponent])
@CanActivate(isAuthenticated)
class VotesComponent implements OnInit {
  StandingsVotesResource _standingsVotesResource;

  StandingsVotes standingsVotes;

  Authentication _authentication;

  SnackBarEvent _snackBarEvent;

  VotesComponent(
      this._standingsVotesResource, this._authentication, this._snackBarEvent);

  User get currentUser => _authentication.currentUser;

  l.Leagues get leagues => l.leagues;

  Standings latestOrBlank(l.League league) =>
      standingsVotes.latest(league) ?? new Standings.blank(league);

  ngOnInit() async {
    var l = (await _standingsVotesResource.list()).body;
    standingsVotes = new StandingsVotes(l);
  }

  void onUserVotedStandings(Standings standings) {
    standingsVotes.add(standings);
    _snackBarEvent.message.add('${standings.league.name}の順位を投票しました。');
  }
}
