import 'package:angular2/core.dart';
import 'package:http_lift/http_lift.dart' hide HttpException;
import 'package:http_lift/middleware/json.dart';
import 'package:http_lift/middleware/xsrf_token.dart';

import 'middleware/http_exception.dart';

// Note: Xsrf protection is superfluous countermeasure for current app spec.
@Injectable()
Handler handlerFactory(HttpExceptionEvents httpExceptionEvents) =>
    composeHandlers([
      json(),
      xsrfToken(),
      new HttpException(httpExceptionEvents).createMiddleware()
    ]);
