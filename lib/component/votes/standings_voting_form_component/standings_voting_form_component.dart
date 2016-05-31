import 'dart:async';
import 'dart:html';

import 'package:angular2/core.dart';
import 'package:npb_polls/component/votes/standings_card_component/standings_card_component.dart';
import 'package:npb_polls/component/votes/standings_vote_component/standings_vote_component.dart';
import 'package:npb_polls/domain/model/standings.dart';
import 'package:npb_polls/domain/model/standings_editor.dart';
import 'package:npb_polls/domain/model/standings_votes.dart';
import 'package:npb_polls/resource/vote/standings_votes_resource.dart';

@Component(
    selector: 'standings-voting-form',
    templateUrl: 'standings_voting_form_component.html',
    styleUrls: const ['standings_voting_form_component.scss.css'],
    directives: const [StandingsVoteComponent, StandingsCardComponent])
class StandingsVotingFormComponent {
  Standings _standings;

  @Output()
  EventEmitter<Standings> userVotedStandings = new EventEmitter<Standings>();

  StandingsEditor standingsEditor;
  StandingsVotesResource _standingsVotesResource;

  bool isSubmitting = false;

  StandingsVotes standingsVotes;

  StandingsVotingFormComponent(this._standingsVotesResource);

  bool get editMode => standingsEditor != null;

  Standings get standings => _standings;

  @Input()
  set standings(Standings standings) {
    if (!editMode) {
      _standings = standings;
      if (!_standings.isVoted) {
        startEdit();
      }
    }
  }

  void endEdit() {
    standingsEditor = null;
  }

  Future onSubmit() async {
    isSubmitting = true;
    Response response =
        await _standingsVotesResource.post(standingsEditor.toStandings());
    isSubmitting = false;
    userVotedStandings.add(response.body);
    endEdit();
  }

  /// For MDV, intentionally not using ngModel on the select tags.
  /// TODO: Handle a team instance instead of teamId.
  void select(Selector selector, Event event) {
    SelectElement element = event.target;
    standingsEditor.select(selector,
        selector.selections.firstWhere((team) => team.id == element.value));
  }

  void startEdit() {
    standingsEditor = new StandingsEditor(standings);
  }

  /// Make sure every select's selected option value equals to the model [id]s.
  ///
  /// On ngAfterViewChecked.
  /// The every [id] is reflected in the name attribute of the select tag.
  /// Looks like there has not been NgSelected for ng2 yet.
  /// It's perhaps transitional implementation.
  /// https://github.com/angular/angular/pull/7842
  /// https://github.com/angular/angular/pull/7939
  @Deprecated('Old impl before beta.14.')
  void _syncEveryOptionDefaultSelected() {
    for (SelectElement selectElement in querySelectorAll('select')) {
      var teamId = selectElement.value;
      for (OptionElement o in selectElement.children) {
        o.defaultSelected = o.value == teamId;
      }
    }
  }
}
