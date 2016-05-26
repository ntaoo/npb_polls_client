import 'package:angular2/core.dart';
import 'package:http_lift/middleware/http_exception.dart' as lift_middleware;

@Injectable()
class HttpException extends lift_middleware.HttpException {
  HttpException(HttpExceptionEvents httpExceptionEvents)
      : super(httpExceptionEvents);
}

@Injectable()
class HttpExceptionEvents extends lift_middleware.HttpExceptionEvents {}
