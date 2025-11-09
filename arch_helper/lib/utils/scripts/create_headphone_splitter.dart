import 'package:arch_helper/utils/classes/script_command.dart';
import 'package:arch_helper/utils/classes/script_response.dart';
import 'package:arch_helper/utils/classes/service_locator.dart';
import 'package:process_run/process_run.dart' show Shell;
import 'package:process_run/stdio.dart';

class CreateHeadphoneSplitter extends ScriptCommand {
  CreateHeadphoneSplitter();

  @override
  String get scriptName => 'Create Headphone Splitter';

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
    ServiceLocator.consoleState.printDebug('Creating virtual splitter');

    ProcessResult pactlResponse = await runExecArg(executable: 'pactl', arguments: ['load-module', 'module-combine-sink'],);
    await runExecArg(executable: 'pactl', arguments: ['list', 'sinks', 'short'],);
    return ScriptResponse(data: pactlResponse, scriptErrorMessage: pactlResponse.stderr, exitCode: pactlResponse.exitCode);
  };

  @override
  Future<List<ScriptResponse>> Function() get scriptVerbose => throw UnimplementedError();
}