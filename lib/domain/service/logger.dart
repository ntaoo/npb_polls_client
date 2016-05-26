import 'dart:html';
import 'package:angular2/core.dart';
import 'package:logging/logging.dart' as logging;

@Injectable()
class Logger {
  final logging.Logger _logger = new logging.Logger('app');

  Logger() {
    // Unless on local development, suppress development level logging.
    logging.Logger.root.level = window.location.host.startsWith('localhost')
        ? logging.Level.ALL
        : logging.Level.WARNING;

    logging.Logger.root.onRecord.listen((logging.LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });
  }

  /// Use it for logging a debug message.
  void fine(message, [Object error, StackTrace stackTrace]) {
    _logger.fine(message, error, stackTrace);
  }
}
