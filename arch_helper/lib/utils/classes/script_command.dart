import 'dart:io';

import 'package:arch_helper/utils/classes/script_response.dart';
import 'package:arch_helper/utils/classes/service_locator.dart' show ServiceLocator;
import 'package:process_run/process_run.dart' show Shell;
import 'package:process_run/stdio.dart' show ProcessResult;

abstract class ScriptCommand {
  const ScriptCommand();

  abstract final String scriptName;
  abstract final bool hasVerbose;
  abstract final bool hasBinary;
  abstract final String? binaryName;
  abstract final Future<ScriptResponse> Function() script;
  abstract final Future<List<ScriptResponse>> Function() scriptVerbose;
  abstract final Shell shell;
  Future<ProcessResult> runExecArg({required String executable, required List<String> arguments}) {
    return shell.runExecutableArguments(executable, arguments)
      .then((res) {
        ServiceLocator.consoleState.printInfo(res.stdout);
        if(res.stderr != '') ServiceLocator.consoleState.printError(res.stderr);
        return res;
      })
      .catchError((res) {
        if(res.runtimeType.toString() == ArgumentError().runtimeType.toString()) throw res;
        ServiceLocator.consoleState.printError(res.result?.stderr);
        return res.result;
      });
  }
  Future<ProcessResult> openBinary({required String binaryName}) async {
    return await runExecArg(executable: 'binaryName', arguments: []);
  }
}