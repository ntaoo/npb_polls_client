import 'dart:collection';
import 'teams.dart';

const leagues =
    const Leagues(const [const CentralLeague(), const PacificLeague()]);

class Leagues extends IterableBase {
  final List _leagues;

  const Leagues(this._leagues);

  Iterator get iterator => _leagues.iterator;

  League getById(String id) => firstWhere((l) => l.id == id);
}

abstract class League {
  String get id;

  String get name;

  /// Note: currently Dart doesn't support [Set] literal and const [Set].
  /// https://github.com/dart-lang/sdk/issues/3792
  /// https://github.com/dart-lang/sdk/issues/174
  List<Team> get teams;
}

class CentralLeague implements League {
  final String id = 'central';
  final String name = 'セントラル・リーグ';
  final List<Team> teams = const [
    baystars,
    carp,
    dragons,
    giants,
    swallows,
    tigers
  ];

  const CentralLeague();
}

class PacificLeague implements League {
  final String id = 'pacific';
  final String name = 'パシフィック・リーグ';
  final List<Team> teams = const [
    buffaloes,
    eagles,
    fighters,
    lions,
    hawks,
    marines
  ];

  const PacificLeague();
}
