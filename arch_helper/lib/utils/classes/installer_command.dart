import 'dart:io';

import 'package:arch_helper/utils/classes/script_response.dart';
import 'package:arch_helper/utils/classes/service_locator.dart' show ServiceLocator;
import 'package:process_run/process_run.dart' show Shell;
import 'package:process_run/stdio.dart' show ProcessResult;

abstract class InstallerCommand {
  const InstallerCommand();

  abstract final String installerName;
  abstract final bool hasVerbose;
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
        ServiceLocator.consoleState.printError(res.result.stderr);
        return res.result;
      });
  }
  Future<ScriptResponse> yayInstall({required String packageName,}) async {
    ProcessResult installResult = await runExecArg(executable: 'pkexec', arguments: ['yay', '-S', packageName, '--noconfirm']);
    return ScriptResponse(
      data: installResult, 
      scriptErrorMessage: installResult.stderr != '' ? installResult.stderr : null, 
      exitCode: installResult.exitCode,
      successful: installResult.stderr == '' && installResult.stdout.toString().contains('Updating the desktop file MIME type cache...'),
    );
  }
  Future<ScriptResponse> yayQuery({required String packageName,}) async {
    ProcessResult queryResult = await runExecArg(executable: 'yay', arguments: ['-Q', packageName]);
    return ScriptResponse(
      data: queryResult,
      scriptErrorMessage: queryResult.stderr != '' ? queryResult.stderr : null,
      exitCode: queryResult.exitCode,
      successful: queryResult.stderr == '',
    );
  }
  Future<ScriptResponse> verboseInstall({required Package p}) async {
    final String displayName = p.displayName;
    final String packageName = p.packageName;
    ServiceLocator.consoleState.printDebug('Checking if $displayName is installed');
    ScriptResponse queryResponse = await yayQuery(packageName: packageName);
    if(queryResponse.successful ?? false) {
      ServiceLocator.consoleState.printDebug('$displayName was installed');
      return queryResponse;
    } else {
      ServiceLocator.consoleState.printDebug('$displayName not installed, installing...');
      return await yayInstall(packageName: packageName);
    }
  }
}

class Package {
  final String displayName;
  final String packageName;
  const Package({
    required this.displayName,
    required this.packageName,
  });
}