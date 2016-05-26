import 'package:angular2/core.dart';

@Injectable()
class SnackBarEvent {
  final EventEmitter<String> message = new EventEmitter<String>();
}
