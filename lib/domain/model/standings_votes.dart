import 'dart:collection';
import 'leagues.dart';
import 'standings.dart';

class StandingsVotes extends IterableBase {
  final List<Standings> _list;

  Iterator get iterator => _list.iterator;

  StandingsVotes(List<Standings> standings)
      : _list = standings
          ..sort((b, a) => a.createdTime.compareTo(b.createdTime));

  Standings latest(League league) =>
      firstWhere((Standings v) => v.league == league, orElse: () => null);

  List<Standings> get history {
    var l = leagues.map(latest);
    return where((s) => !l.contains(s)).toList();
  }

  void add(Standings standings) {
    _list.insert(0, standings);
  }
}
