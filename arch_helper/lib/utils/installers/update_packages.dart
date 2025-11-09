import 'package:arch_helper/utils/classes/installer_command.dart';
import 'package:arch_helper/utils/classes/script_response.dart';
import 'package:arch_helper/utils/classes/service_locator.dart';
import 'package:process_run/process_run.dart' show Shell;
import 'package:process_run/stdio.dart' show ProcessResult;

class UpdatePackages extends InstallerCommand {
  UpdatePackages();

  @override
  String get installerName => 'Update Packages';

  @override
  Shell get shell => Shell();

  @override
  bool get hasVerbose => true;

  //TODO: CHECK IF UPDATE NEEDED BEFORE UPDATING

  @override
  Future<ScriptResponse> Function() get script => () async {
    ServiceLocator.consoleState.printDebug('Updating package dependencies');
    ProcessResult yayUpdateResult = await runExecArg(executable: 'pkexec', arguments: ['yay', '-Syu', '--noconfirm'],);
    await runExecArg(executable: 'pkexec', arguments: ['flatpak', 'update', '--assumeyes'],);
    return ScriptResponse(data: yayUpdateResult,);
  };

  @override
  Future<List<ScriptResponse>> Function() get scriptVerbose => () async {
    ServiceLocator.consoleState.printDebug('Updating package dependencies');
    ProcessResult yayUpdateResult = await runExecArg(executable: 'pkexec', arguments: ['yay', '-Syu', '--noconfirm'],);
    ProcessResult flatpakUpdateResult = await runExecArg(executable: 'pkexec', arguments: ['flatpak', 'update', '--assumeyes'],);
    return [ScriptResponse(data: yayUpdateResult, scriptErrorMessage: yayUpdateResult.stderr != '' ? yayUpdateResult.stderr : null, exitCode: yayUpdateResult.exitCode), ScriptResponse(data: flatpakUpdateResult, scriptErrorMessage: flatpakUpdateResult.stderr != '' ? flatpakUpdateResult.stderr : null, exitCode: flatpakUpdateResult.exitCode)];
  };
}