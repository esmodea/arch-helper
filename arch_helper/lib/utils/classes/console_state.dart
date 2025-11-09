import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class ConsoleState with ChangeNotifier {
  late Logger _logger = Logger(printer: _printer, output: _streamOutput);
  final StreamOutput _streamOutput = StreamOutput();
  LogPrinter _printer = SimplePrinter(colors: false);
  final List<String> _releaseLogs = [];

  Logger get logger => _logger;
  StreamOutput get loggerStream => _streamOutput;
  List<String> get releaseLogs => _releaseLogs;

  void setPrinter({required LogPrinter printer}) {
    _printer = printer;
    _logger = Logger(printer: _printer, output: _streamOutput);
    notifyListeners();
  }

  void togglePrettyPrinter() {
    if(_printer == PrettyPrinter(colors: false)) {
      setPrinter(printer: SimplePrinter(colors: false));
    } else {
      setPrinter(printer: PrettyPrinter(colors: false));
    }
  }

  void printDebug(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    debugPrint(message);
    List logs = '[D] $message'.split('\n');
    logs.removeLast();
    if(kReleaseMode)_releaseLogs.add(logs.join('\n[D] '));
    logger.d(message, time: time, error: error, stackTrace: stackTrace);
  }

  void printError(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    debugPrint(message);
    List logs = '[E] $message'.split('\n');
    logs.removeLast();
    if(kReleaseMode)_releaseLogs.add(logs.join('\n[E] '));
    logger.e(message, time: time, error: error, stackTrace: stackTrace);
  }

  void printInfo(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    debugPrint(message);
    List logs = '[I] $message'.split('\n');
    logs.removeLast();
    if(kReleaseMode)_releaseLogs.add(logs.join('\n[I] '));
    logger.log(Level.warning, message, time: time, error: error, stackTrace: stackTrace);
  }
}