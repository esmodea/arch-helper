import 'package:arch_helper/utils/classes/installer_command.dart';
import 'package:arch_helper/utils/classes/script_response.dart';
import 'package:process_run/process_run.dart';
 
class DolphinInstaller extends InstallerCommand {
  const DolphinInstaller();
  
  @override
  String get installerName => 'Install Dolphin Emulator';

  @override
  bool get hasVerbose => false;

  @override
  Shell get shell => Shell();

  @override
  Future<ScriptResponse> Function() get script => () async {
    //TODO: SET UP FUNCTIONALITY FOR CREATING VIRTUAL FOLDER
    return await verboseInstall(p: Package(displayName: 'Dolphin', packageName: 'dolphin-emu'));
  };

  @override
  Future<List<ScriptResponse>> Function() get scriptVerbose => throw UnimplementedError();
}