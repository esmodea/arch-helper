import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ConsoleState with ChangeNotifier {
  late Logger _logger = Logger(printer: _printer, output: _streamOutput);
  final StreamOutput _streamOutput = StreamOutput();
  LogPrinter _printer = SimplePrinter(colors: false);

  Logger get logger => _logger;
  StreamOutput get loggerStream => _streamOutput;

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
    _logger = Logger(printer: _printer, output: _streamOutput);
    logger.d(message, time: time, error: error, stackTrace: stackTrace);
  }

  void printError(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    debugPrint(message);
    _logger = Logger(printer: _printer, output: _streamOutput);
    logger.e(message, time: time, error: error, stackTrace: stackTrace);
  }

  void printInfo(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    debugPrint(message);
    _logger = Logger(printer: _printer, output: _streamOutput);
    logger.i(message, time: time, error: error, stackTrace: stackTrace);
  }
}