import 'dart:io';
import 'package:arch_helper/utils/classes/installer_command.dart';
import 'package:arch_helper/utils/classes/script_response.dart';
import 'package:arch_helper/utils/classes/service_locator.dart';
import 'package:process_run/process_run.dart' show Shell;

class CupsInstaller extends InstallerCommand{
  const CupsInstaller();

  @override
  String get installerName => 'Cups Installer';

  @override
  Shell get shell => Shell();

  @override
  bool get hasVerbose => false;

  @override
  Future<ScriptResponse> Function() get script => () async {
    ServiceLocator.consoleState.printDebug('Installing Cups');
    String? cupsProcessStderr;
    String? cupsProcessStdout;
    String? cupsEnableProcessStderr;
    String? cupsEnableProcessStdout;

    bool isErr = false;
    
    
    // try {
      // ProcessResult cupsProcess = await 
      ProcessResult cupsProcess = await shell.runExecutableArguments('pkexec', ['pacman', '-Sc', 'cups', '--noconfirm',]).then((res) {
        // if(res.stdout != null) ServiceLocator.consoleState.printInfo(res.stdout.toString(),);
        if(res.stdout != null) cupsProcessStdout = res.stdout.toString();
        // if(res.stderr != null) ServiceLocator.consoleState.printError(res.stderr.toString(),);
        if(res.stderr != null) cupsProcessStderr = res.stderr.toString();
        return res;
      }).catchError((res) {
        // ServiceLocator.consoleState.printInfo(res.result.stderr.toString(),);
        if(res.result.stderr != null) cupsProcessStderr = res.result.stderr.toString();
        isErr = true;
        return res.result;
      });

      // cupsProcessStdout = cupsProcess.stdout;
      // cupsProcessStderr = cupsProcess.stderr;

      if(!isErr) {
        // try {
          // ProcessResult cupsEnableProcess = await 
          shell.runExecutableArguments('pkexec', ['systemctl', 'enable', 'cups',]).then((res) {
            // if(res.stdout != null) ServiceLocator.consoleState.printInfo(res.stdout.toString(),);
            if(res.stdout != null) cupsEnableProcessStdout = res.stdout.toString();
            // if(res.stderr != null) ServiceLocator.consoleState.printError(res.stderr.toString(),);
            if(res.stderr != null) cupsEnableProcessStderr = res.stderr.toString();
            return res;
          }).catchError((res) {
            // ServiceLocator.consoleState.printInfo(res.result.stderr.toString(),);
            if(res.result.stderr != null) cupsEnableProcessStderr = res.result.stderr.toString();
            return res.result;
          });

          // cupsEnableProcessStderr = cupsEnableProcess.stderr;
          // cupsEnableProcessStdout = cupsEnableProcess.stdout;
  
        // } catch (e, stackTrace) {
        //   ServiceLocator.consoleState.printError('Error enabling cups', stackTrace: stackTrace);
        // }
      }

      if(cupsProcessStdout?.isNotEmpty ?? false) ServiceLocator.consoleState.printInfo(cupsProcessStdout);
      if(cupsProcessStderr?.isNotEmpty ?? false) ServiceLocator.consoleState.printError(cupsProcessStderr);
      if(cupsEnableProcessStdout?.isNotEmpty ?? false) ServiceLocator.consoleState.printInfo(cupsEnableProcessStdout);
      if(cupsEnableProcessStderr?.isNotEmpty ?? false) ServiceLocator.consoleState.printError(cupsEnableProcessStderr);
      return ScriptResponse(data: cupsProcess, scriptErrorMessage: cupsProcess.stderr, exitCode: cupsProcess.exitCode);
    // } catch (e, stackTrace) {
    //   ServiceLocator.consoleState.printError('Error installing cups', stackTrace: stackTrace);
    // }
  };

  @override
  Future<List<ScriptResponse>> Function() get scriptVerbose => throw UnimplementedError();
}