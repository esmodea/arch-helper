import 'package:arch_helper/utils/classes/installer_command.dart';
import 'package:arch_helper/utils/classes/script_response.dart';
import 'package:process_run/process_run.dart' show Shell;

class PavucontrolInstaller extends InstallerCommand {
  const PavucontrolInstaller();

  @override
  String get installerName => 'Install Pavucontrol (For audio configuration)';

  @override
  Shell get shell => Shell();

  @override
  bool get hasVerbose => false;

  @override
  Future<ScriptResponse> Function() get script => () async {
    return await verboseInstall(p: Package(displayName: 'pavucontrol', packageName: 'pavucontrol'));
  };

  @override
  Future<List<ScriptResponse>> Function() get scriptVerbose => throw UnimplementedError();
}