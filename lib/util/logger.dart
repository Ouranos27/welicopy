import 'package:logger/logger.dart';

var logger = Logger();

final _logi = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    printEmojis: false,
    printTime: false,
    lineLength: 150,
  ),
);

void debugConsoleLog(dynamic message) => _logi.d(message);
