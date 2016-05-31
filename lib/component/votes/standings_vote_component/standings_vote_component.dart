import 'package:angular2/core.dart';
import 'package:angular2/common.dart';
import '../standings_card_component/standings_card_component.dart';
import 'package:npb_polls/domain/model/standings.dart';

@Component(
    selector: 'standings-vote',
    templateUrl: 'standings_vote_component.html',
    directives: const [standingsCardDirectives],
    pipes: const [DatePipe],
    changeDetection: ChangeDetectionStrategy.OnPush)
class StandingsVoteComponent {
  @Input()
  Standings standings;
}
