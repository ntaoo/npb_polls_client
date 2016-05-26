import 'package:angular2/core.dart';
import 'package:npb_polls/domain/model/standings_poll.dart';
import 'package:npb_polls/resource/poll/standings_polls_resource.dart';

import 'src/doughnut_chart_component.dart';
import 'src/standing_votes_component.dart';

@Component(
    selector: 'standings-polls',
    templateUrl: 'standings_polls_component.html',
    styleUrls: const ['standings_polls_component.css'],
    directives: const [DoughnutChartComponent, StandingVotesComponent])
class StandingsPollsComponent implements OnInit {
  StandingsPollsResource _standingsPollsResource;

  List<StandingsPoll> standingsPolls;

  StandingsPollsComponent(this._standingsPollsResource);

  ngOnInit() async {
    standingsPolls = (await _standingsPollsResource.list()).body;
  }
}
