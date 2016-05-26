/// Workaround code for the @CanActivate issue.
/// See https://github.com/angular/angular/issues/4112.

import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:npb_polls/domain/service/authentication.dart';

Injector appInjector;

void setAppInjector(Injector injector) {
  appInjector = injector;
}

Future<bool> isAuthenticated(
    ComponentInstruction _, ComponentInstruction __) async {
  Authentication authentication = appInjector.get(Authentication);

  bool _isAuthenticated = await authentication.check();

  if (!_isAuthenticated) appInjector.get(Router).navigate(['Home']);
  return _isAuthenticated;
}
