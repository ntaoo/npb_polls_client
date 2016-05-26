import 'package:npb_polls/domain/model/leagues.dart';
import 'package:npb_polls/domain/model/teams.dart';
import 'package:npb_polls/domain/model/standings.dart';

import 'selector.dart';
import 'unselected.dart';

class StandingsEditor {
  final List<Selector> selectors;

  final League _league;

  /// All teams in this [_league]. The order is shuffled at the constructor.
  ///
  /// Note: The default implementation of `Set` is `LinkedHashSet` which keeps
  /// track of the order that elements were inserted in.
  final Set<Team> _teams;

  StandingsEditor(Standings standings)
      : selectors = standings.map((s) => new Selector(s)).toList(),
        _league = standings.league,
        _teams = (new List.from(standings.league.teams)..shuffle()).toSet() {
    _setSelections();
  }

  /// Whether every selector's team is filled with different team in the league.
  bool get isFilledAll =>
      selectors.map((s) => s.selectedTeam).toSet().difference(_teams).isEmpty;

  /// Whether any standing is filled.
  bool get isFilledAny => selectors.any((s) => s.selectedTeam != unselected);

  String get leagueId => _league.id;

  String get leagueName => _league.name;

  void clear(Selector selector) {
    _validateSelector(selector);
    selector.selectedTeam = unselected;
    _setSelections();
  }

  void clearAll() {
    for (var selector in selectors) selector.selectedTeam = unselected;
    _setSelections();
  }

  void select(Selector selector, Team team) {
    _validateSelector(selector);
    selector.selectedTeam = team;
    _setSelections();
  }

  Standings toStandings() =>
      new Standings(_league, selectors.map((s) => s.toStanding()).toList());

  void _setSelections() {
    for (var s in selectors) s.setSelections(_teams, selectors);
  }

  void _validateSelector(Selector selector) {
    if (!selectors.contains(selector))
      throw new StateError('The selector is not in the editor');
  }
}
