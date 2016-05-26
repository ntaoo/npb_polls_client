import 'package:angular2/core.dart';
import 'package:angular2/common.dart';
import 'package:npb_polls/domain/model/standings_poll.dart' show StandingPoll;

@Component(
    selector: 'standing-votes',
    template: '''
        <div class="number" [style.border-left-color]="vote.team.color" *ngFor="let vote of standingPoll.votes">
          {{vote.team.name | slice:0:1}}: {{vote.number}}
        </div>
        ''',
    styles: const [
      '''
        :host {
          margin: 0 10px;
        }

        .number {
          border-left: 5px solid;
          padding-left: 2px;
          margin: 1px 2px;
        }
      '''
    ],
    pipes: const [SlicePipe],
    changeDetection: ChangeDetectionStrategy.OnPush)
class StandingVotesComponent {
  @Input()
  StandingPoll standingPoll;
}
