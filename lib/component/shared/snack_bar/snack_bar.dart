import 'dart:async';
import 'dart:collection';

import 'package:angular2/core.dart';

/// Simplified snack bar implementation ported from MDL snack bar.
/// FIXME: Messages in notifications queue are not reflected into the template.
@Component(
    selector: 'snack-bar',
    template: '<div class="mdl-snackbar__text">{{message}}</div>',
    styleUrls: const ['./snack_bar.css'])
class SnackBar {
  bool isActive = false;
  String message;
  final Queue<String> _notifications = new Queue<String>();
  final Renderer _renderer;
  final ElementRef _elementRef;
  final int _animationLength = 250;
  final int _timeOut = 2750;
  final Map _cssClasses = const {
    'snackbar': 'mdl-snackbar',
    'active': 'mdl-snackbar--active'
  };

  SnackBar(this._renderer, this._elementRef) {
    _renderer.setElementClass(
        _elementRef.nativeElement, _cssClasses['snackbar'], true);
  }

  void show(String msg) {
    if (msg == null)
      throw new ArgumentError('SnackBar message cannot be null.');
    if (isActive) {
      _notifications.add(msg);
    } else {
      isActive = true;
      message = msg;
    }
    _display();
  }

  void _checkQueue() {
    if (_notifications.length > 0) {
      show(_notifications.removeFirst());
    }
  }

  void _cleanUp() {
    _renderer.setElementClass(
        _elementRef.nativeElement, _cssClasses['active'], false);

    new Timer(new Duration(milliseconds: _animationLength), () {
      _renderer.setElementAttribute(
          _elementRef.nativeElement, 'aria-hidden', 'true');
      message = null;
      isActive = false;
      _checkQueue();
    });
  }

  void _display() {
    _renderer.setElementAttribute(
        _elementRef.nativeElement, 'aria-hidden', 'true');
    _renderer.setElementClass(
        _elementRef.nativeElement, _cssClasses['active'], true);
    _renderer.setElementAttribute(
        _elementRef.nativeElement, 'aria-hidden', 'false');
    new Timer(new Duration(milliseconds: _timeOut), _cleanUp);
  }
}
