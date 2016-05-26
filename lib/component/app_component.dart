// Copyright (c) 2016, <ntaoo>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:chartjs/chartjs.dart';
import 'package:npb_polls/component/home/home_component.dart';
import 'package:npb_polls/component/votes/votes_component.dart';
import 'package:npb_polls/domain/service/authentication.dart';
import 'package:npb_polls/domain/service/logger.dart';
import 'package:npb_polls/resource/resource.dart';
import 'shared/is_authenticated.dart';
import 'shared/snack_bar/snack_bar.dart';
import 'shared/snack_bar/snack_bar_event.dart';

@Component(
    selector: 'npb-polls',
    templateUrl: 'app_component.html',
    styleUrls: const [
      'app_component.css'
    ],
    providers: const [
      ROUTER_PROVIDERS,
      resourceProviders,
      Authentication,
      Logger,
      SnackBarEvent
    ],
    directives: const [
      ROUTER_DIRECTIVES,
      SnackBar
    ])
@RouteConfig(const [
  const Route(
      path: '/', name: 'Home', component: HomeComponent, useAsDefault: true),
  const Route(path: '/votes', name: 'Votes', component: VotesComponent)
])
class AppComponent {
  final Authentication authentication;
  final Router _router;
  final Injector _injector;
  final HttpExceptionEvents _httpExceptionEvents;
  final Logger _logger;
  final SnackBarEvent _snackBarEvent;
  @ViewChild(SnackBar)
  SnackBar snackBar;

  AppComponent(this.authentication, this._router, this._injector,
      this._httpExceptionEvents, this._logger, this._snackBarEvent) {
    setAppInjector(this._injector);

    _httpExceptionEvents.onUnauthorizedException
        .listen(_handleUnauthorizedException);
    _httpExceptionEvents.onHttpException.listen(_handleHttpException);
    _setChartjsDefault();
    _snackBarEvent.message.listen((String message) => snackBar.show(message));

    authentication.check();
  }

  User get currentUser => authentication.currentUser;

  bool isActive(String routeName) =>
      routeName == _router.currentInstruction?.component?.routeName;

  void _handleHttpException(HttpException _) {
    _snackBarEvent.message.add('通信エラーが発生しました');
  }

  void _handleUnauthorizedException(UnauthorizedException _) {
    _logger.fine('AppComponent: _handleUnauthorizedException');
    _router.navigate(['Home']);
    _snackBarEvent.message.add('サインインが必要です');
  }

  void _setChartjsDefault() {
    // When setting it to true, chart.js throws this error on drawing a doughnutsChart in DoughnutsChartComponent.
    // Uncaught IndexSizeError: Failed to execute 'arc' on 'CanvasRenderingContext2D': The radius provided (-0.5) is negative.
    // Updating chart.js to v2.0 could fix this issue.
    // https://github.com/chartjs/Chart.js/pull/1470
    Chart.defaults.global.responsive = false;
  }
}
