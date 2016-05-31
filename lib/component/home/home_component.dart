import 'package:angular2/core.dart';
import 'package:npb_polls/domain/service/authentication.dart';

import 'package:npb_polls/component/home/sign_in_component/sign_in_component.dart';
import 'standings_polls_component/standings_polls_component.dart';

@Component(
    selector: 'x-home',
    templateUrl: 'home_component.html',
    styleUrls: const ['home_component.scss.css'],
    directives: const [SignInComponent, StandingsPollsComponent])
class HomeComponent {
  Authentication authentication;
  bool isDelayed = false;

  HomeComponent(this.authentication) {
    new Future.delayed(const Duration(seconds: 3), () => isDelayed = true);
  }

  User get currentUser => authentication.currentUser;
}
