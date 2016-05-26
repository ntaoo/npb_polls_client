import 'package:angular2/core.dart';

import 'package:http_lift/http_lift.dart' as lift;
export 'package:http_lift/http_lift.dart' hide LiftClient;

const handler = const OpaqueToken('Handler');

@Injectable()
class LiftClient extends lift.LiftClient {
  LiftClient(@Inject(handler) handler) : super(handler);
}
