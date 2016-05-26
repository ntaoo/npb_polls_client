import 'dart:collection';
import 'leagues.dart';
import 'teams.dart';
import 'standings_editor.dart' show unselected;

class Standing {
  final int number;
  final Team team;

  const Standing(this.number, this.team);
}

class Standings extends IterableBase {
  final League league;
  final List<Standing> _standings;
  final DateTime createdTime;

  const Standings(this.league, this._standings, [this.createdTime = null]);

  Standings.blank(League league)
      : league = league,
        _standings = new List.generate(league.teams.length,
            (int index) => new Standing(index + 1, unselected)),
        createdTime = null;

  Iterator get iterator => _standings.iterator;

  bool get isVoted => createdTime != null;
}
