import 'dart:io';

class ScriptResponse {
  final ProcessResult? data;
  final String? scriptErrorMessage;
  final int? exitCode;
  final bool? successful;
  const ScriptResponse({
    this.data,
    this.scriptErrorMessage,
    this.exitCode,
    this.successful,
  });
}