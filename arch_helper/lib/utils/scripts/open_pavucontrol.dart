import 'dart:io';

import 'package:arch_helper/utils/classes/script_command.dart';
import 'package:arch_helper/utils/classes/script_response.dart';
import 'package:arch_helper/utils/classes/service_locator.dart';
import 'package:arch_helper/utils/installers/pavucontrol_installer.dart';
import 'package:process_run/process_run.dart' show Shell;

class ConfigureAudio extends ScriptCommand {
  ConfigureAudio();

  @override
  String get scriptName => 'Open Audio Config GUI';

  @override
  Shell get shell => Shell();

  void stopBinary(int pid, ProcessResult res) {
    shell.kill(ProcessSignal.sigkill);
  }
  
  @override
  bool get hasVerbose => false;

  @override
  bool get hasBinary => true;

  @override
  String? get binaryName => 'pavucontrol';

  @override
  Future<ScriptResponse> Function() get script => () async {
    ServiceLocator.consoleState.printDebug('Attempting to install if not installed...');
    await PavucontrolInstaller().script();
    ServiceLocator.consoleState.printDebug('Opening Audio Config GUI');
    ProcessResult pavucontrolRes = await runExecArg(executable: 'pavucontrol', arguments: []);
    return ScriptResponse(data: pavucontrolRes, scriptErrorMessage: pavucontrolRes.stderr, exitCode: pavucontrolRes.exitCode);
  };

  @override
  Future<List<ScriptResponse>> Function() get scriptVerbose => throw UnimplementedError();
}