import 'package:angular2/core.dart';

import 'poll/standings_polls_resource.dart';
import 'src/http_lift/handler_factory.dart';
import 'src/http_lift/lift_client.dart';
import 'src/http_lift/middleware/http_exception.dart';
import 'user/current_user_resource.dart';
import 'user/google_users_resource.dart';
import 'vote/standings_votes_resource.dart';

export 'src/http_lift/lift_client.dart';
export 'src/http_lift/middleware/http_exception.dart' show HttpExceptionEvents;

const List resourceProviders = const [
  HttpExceptionEvents,
  const Provider(handler,
      useFactory: handlerFactory, deps: const [HttpExceptionEvents]),
  const Provider(LiftClient, useClass: LiftClient),
  CurrentUserResource,
  GoogleUsersResource,
  StandingsVotesResource,
  StandingsPollsResource,
];
