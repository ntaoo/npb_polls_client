import 'package:npb_polls/domain/model/teams.dart';
import 'package:npb_polls/domain/model/standings.dart';

import 'unselected.dart';

class Selector {
  Team _selectedTeam;

  Set<Team> _selections;

  final Standing _standing;

  Selector(Standing standing)
      : _standing = standing,
        _selectedTeam = standing.team;

  bool get isFilled => selectedTeam != unselected;

  int get number => _standing.number;

  Team get selectedTeam => _selectedTeam;

  set selectedTeam(Team team) {
    if (!_selections.contains(team))
      throw new StateError('The team is not in the selection');
    _selectedTeam = team;
  }

  Set<Team> get selections => _selections;

  void setSelections(Set<Team> allTeams, List<Selector> selectors) {
    var otherTeams = selectors
        .where((s) =>
            s.selectedTeam != selectedTeam && s.selectedTeam != unselected)
        .map((s) => s.selectedTeam)
        .toSet();
    _selections = allTeams.difference(otherTeams)..add(unselected);
  }

  Standing toStanding() => new Standing(number, selectedTeam);
}
