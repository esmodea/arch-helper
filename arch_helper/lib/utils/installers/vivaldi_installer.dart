import 'package:arch_helper/utils/classes/installer_command.dart';
import 'package:arch_helper/utils/classes/script_response.dart';
import 'package:process_run/process_run.dart';
 
class VivaldiInstaller extends InstallerCommand {
  const VivaldiInstaller();
  
  @override
  String get installerName => 'Install Vivaldi-snapshot';

  @override
  bool get hasVerbose => false;

  @override
  Shell get shell => Shell();

  @override
  Future<ScriptResponse> Function() get script => () async {
    //TODO: ADD CUSTOM CONFIG FILES FOR AUTO DUCKDUCKGO AS DEFAULT BROWSER AND EMPTY START PAGE
    return await verboseInstall(p: Package(displayName: 'Vivaldi-snapshot', packageName: 'vivaldi-snapshot'));
  };

  @override
  Future<List<ScriptResponse>> Function() get scriptVerbose => throw UnimplementedError();
}