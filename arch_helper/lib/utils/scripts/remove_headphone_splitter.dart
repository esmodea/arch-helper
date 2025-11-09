import 'package:arch_helper/utils/classes/script_command.dart';
import 'package:arch_helper/utils/classes/script_response.dart';
import 'package:arch_helper/utils/classes/service_locator.dart';
import 'package:process_run/process_run.dart' show Shell;
import 'package:process_run/stdio.dart';

class RemoveHeadphoneSplitter extends ScriptCommand {
  RemoveHeadphoneSplitter();

  @override
  String get scriptName => 'Remove All Headphone Splitters';

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
    ServiceLocator.consoleState.printDebug('Removing all virtual splitters');
    ProcessResult pactlResponse = await runExecArg(executable: 'pactl', arguments: ['unload-module', 'module-combine-sink'],);
    await runExecArg(executable: 'pactl', arguments: ['list', 'sinks', 'short'],);
    return ScriptResponse(data: pactlResponse, scriptErrorMessage: pactlResponse.stderr, exitCode: pactlResponse.exitCode);
  };

  @override
  Future<List<ScriptResponse>> Function() get scriptVerbose => throw UnimplementedError();
}