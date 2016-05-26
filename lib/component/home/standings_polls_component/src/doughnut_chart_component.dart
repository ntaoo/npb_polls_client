import 'dart:html';

import 'package:angular2/core.dart';
import 'package:chartjs/chartjs.dart';
import 'package:npb_polls/domain/model/standings_poll.dart' show StandingPoll;

@Component(
    selector: 'doughnut-chart',
    template: '''
        <canvas #doughnutChart [height]="height" [width]="width"></canvas>
        <div class="caption">
          <div><span class="standing-number">{{standingPoll.number}}</span>位</div>
          <div>最多得票球団</div>
          <div class="team-name" [style.color]="standingPoll.votes.first.team.color">{{standingPoll.votes.first.team.name}}</div>
          <div class="number">{{standingPoll.votes.first.number}}票</div>
        </div>
        ''',
    styles: const [
      '''
        :host {position: relative;}
        .caption {
          position: absolute;
          top:0;
          left: 0;
          right: 0;
          bottom: 0;
          display: flex;
          flex-direction: column;
          justify-content: center;
          text-align: center;
        }
        .standing-number {
          font-size: 24px;
        }
        .team-name, .number {
          font-weight: bold;
          font-size: 18px;
          margin: 3px;
        }
      '''
    ],
    changeDetection: ChangeDetectionStrategy.OnPush)
class DoughnutChartComponent implements AfterViewInit {
  @Input()
  StandingPoll standingPoll;
  @Input()
  String width;
  @Input()
  String height;
  @ViewChild('doughnutChart')
  ElementRef doughnutChartRef;

  CanvasElement get _canvas => doughnutChartRef.nativeElement;

  ngAfterViewInit() => new Chart(_canvas.context2D).Doughnut(
      standingPoll.circularChartDataList,
      new PieChartOptions(percentageInnerCutout: 65));
}
