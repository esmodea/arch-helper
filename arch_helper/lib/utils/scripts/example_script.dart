import 'dart:io';
import 'package:arch_helper/utils/classes/script_command.dart' show ScriptCommand;
import 'package:arch_helper/utils/classes/script_response.dart';
import 'package:arch_helper/utils/classes/service_locator.dart';
import 'package:process_run/process_run.dart' show Shell;

class ExampleScript extends ScriptCommand {
  const ExampleScript();

  @override
  String get scriptName => 'Sanity Example';

  @override
  Shell get shell => Shell();

  @override
  bool get hasVerbose => false;

  @override
  bool get hasBinary => false;

  @override
  String? get binaryName => throw UnimplementedError();

  @override
  Future<ScriptResponse> Function() get script => () async {
    ServiceLocator.consoleState.printDebug('Running Example');
    ProcessResult result = await runExecArg(executable: 'echo', arguments: ['hello world']);
    return ScriptResponse(data: result, scriptErrorMessage: result.stderr, exitCode: result.exitCode);
  };

  @override
  Future<List<ScriptResponse>> Function() get scriptVerbose => throw UnimplementedError();
}