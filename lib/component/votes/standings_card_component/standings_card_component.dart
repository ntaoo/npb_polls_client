import 'package:angular2/core.dart';

const standingsCardDirectives = const [
  StandingsCardComponent,
  StandingComponent
];

@Component(
    selector: 'standing',
    templateUrl: 'standing_component.html',
    encapsulation: ViewEncapsulation.None,
    changeDetection: ChangeDetectionStrategy.OnPush)
class StandingComponent {}

@Component(
    selector: 'standings-card',
    templateUrl: 'standings_card_component.html',
    styleUrls: const ['standings_card_component.css'])
class StandingsCardComponent {
  Renderer _renderer;
  ElementRef _elementRef;
  String _elevation;

  StandingsCardComponent(this._renderer, this._elementRef);

  // Inspired by md-toolbar on angular/material2.
  // Not clean impl.
  // Is using ngOnChange better?
  @Input()
  set elevation(String value) {
    if (_elevation != null) {
      _renderer.setElementClass(
          _elementRef.nativeElement, 'mdl-shadow--${_elevation}dp', false);
    }
    _renderer.setElementClass(
        _elementRef.nativeElement, 'mdl-shadow--${value}dp', true);
    _elevation = value;
  }
}
