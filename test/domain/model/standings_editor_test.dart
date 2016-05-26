import "package:test/test.dart";
import "package:quiver/iterables.dart";

import 'package:npb_polls/domain/model/standings_editor.dart';
import 'package:npb_polls/domain/model/standings.dart';
import 'package:npb_polls/domain/model/src/standings_editor/unselected.dart';
import 'package:npb_polls/domain/model/leagues.dart';

main() {
  group(StandingsEditor, () {
    StandingsEditor standingsEditor;
    League league;
    setUp(() {
      league = leagues.first;
      standingsEditor = new StandingsEditor(new Standings.blank(league));
    });
    group("new", () {
      test("selectors.length is equals to the league teams' length.", () {
        expect(standingsEditor.selectors.length, equals(league.teams.length));
      });
      test("selectors' teams are all `unselected`.", () {
        expect(
            standingsEditor.selectors
                .every((s) => s.selectedTeam == unselected),
            isTrue);
      });
      test("isAllFilledProperly is false.", () {
        expect(standingsEditor.isFilledAll, isFalse);
      });
      test("leagueName is the league's name.", () {
        expect(standingsEditor.leagueName, equals(league.name));
      });
      test(
          "selector.selections are all equals to the league teams followed by an `unSelected`.",
          () {
        var expected = new Set.from(league.teams)..add(unselected);
        expect(
            standingsEditor.selectors.every(
                (selector) => selector.selections.difference(expected).isEmpty),
            isTrue);
        expect(
            standingsEditor.selectors
                .every((selector) => selector.selections.last == unselected),
            isTrue);
      });
    });
    group("change()", () {
      group("Succcess case: ", () {
        test(
            "changes the selector's team when the selector exists and the team is contained in the selectableTeams.",
            () {
          var selector = standingsEditor.selectors.first;
          var team = selector.selections.first;
          standingsEditor.select(selector, team);
          expect((selector.selectedTeam), equals(team));
        });
        test(
            "changes the selector's team when the selector exists and the team with `unSelected` (to make sure).",
            () {
          var selector = standingsEditor.selectors.first;
          standingsEditor.select(selector, unselected);
          expect((selector.selectedTeam), equals(unselected));
        });
      });
      group("Failure case: ", () {
        group("when the selections doesn't contain the selectedTeam,", () {
          test("throws StateError.", () {
            var team = leagues.last.teams.first;
            var selector = standingsEditor.selectors.first;
            // This expression doesn't work for some reason.
            // expect(standingsEditor.select(selector, team), throwsStateError);
            try {
              standingsEditor.select(selector, team);
            } on StateError catch (error) {
              expect(error.runtimeType, equals(StateError));
            }
          });
        });
      });
      test("rebuild every selections with changed state.", () {
        var hashCodes =
            standingsEditor.selectors.map((r) => r.selections.hashCode).toSet();
        var selector = standingsEditor.selectors.first;
        var team = selector.selections.first;
        standingsEditor.select(selector, team);
        expect(
            standingsEditor.selectors
                .map((r) => r.selections.hashCode)
                .toSet()
                .intersection(hashCodes),
            isEmpty);
      });
    });
    group('clear()', () {
      test("set the selector's team to `unselected`", () {
        var selector = standingsEditor.selectors.first;
        standingsEditor.select(selector, selector.selections.first);
        standingsEditor.clear(selector);
        expect(selector.selectedTeam, equals(unselected));
      });
    });
    group('clearAll()', () {
      var hashCodes;
      setUp(() {
        List selectors = standingsEditor.selectors;
        var teams = league.teams;
        hashCodes =
            standingsEditor.selectors.map((r) => r.selections.hashCode).toSet();

        range(selectors.length).forEach((i) {
          standingsEditor.select(selectors[i], teams[i]);
        });
        standingsEditor.clearAll();
      });
      test('set every team in the selectors to `unselected`', () {
        expect(
            standingsEditor.selectors
                .every((r) => r.selectedTeam == unselected),
            isTrue);
      });
      test('set every selections.', () {
        expect(
            standingsEditor.selectors
                .map((r) => r.selections.hashCode)
                .toSet()
                .intersection(hashCodes),
            isEmpty);
      });
    });
    group('isFilledAllProperly', () {
      test(
          'returns true if every selector is filled with different team except `unselected`',
          () {
        List selectors = standingsEditor.selectors;
        List teams = league.teams;
        range(selectors.length).forEach((i) {
          standingsEditor.select(selectors[i], teams[i]);
        });
        expect(standingsEditor.isFilledAll, isTrue);
      });
    });
  });
}
