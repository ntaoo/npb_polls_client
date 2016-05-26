import 'dart:collection';
import 'package:chartjs/chartjs.dart' show CircularChartData;

import 'leagues.dart';
import 'teams.dart';

export 'leagues.dart';

class StandingsPoll extends IterableBase {
  final League league;
  final List<StandingPoll> _standingsPoll;

  StandingsPoll(this.league, List<StandingPoll> standingsPoll)
      : _standingsPoll = standingsPoll
          ..sort((a, b) => a.number.compareTo(b.number));

  Iterator get iterator => _standingsPoll.iterator;
}

class StandingPoll {
  final int number;
  final List<Vote> votes;

  StandingPoll(this.number, List<Vote> votes)
      : votes = votes..sort((b, a) => a.number.compareTo(b.number));

  List<CircularChartData> get circularChartDataList =>
      votes.map((v) => v.toCircularChartData()).toList();
}

class Vote {
  final Team team;
  final int number;

  Vote(this.team, this.number);

  CircularChartData toCircularChartData() => new CircularChartData(
      value: number,
      color: team.color,
      highlight: team.color,
      label: team.name);
}
