import 'package:arch_helper/utils/classes/installer_command.dart';
import 'package:arch_helper/utils/classes/script_response.dart';
import 'package:process_run/process_run.dart';
 
class ExampleInstaller extends InstallerCommand {
  const ExampleInstaller();
  
  @override
  String get installerName => 'Install Example';

  @override
  bool get hasVerbose => false;

  @override
  Shell get shell => Shell();

  @override
  Future<ScriptResponse> Function() get script => () async {
    return await verboseInstall(p: Package(displayName: 'Example', packageName: 'example'));
  };

  @override
  Future<List<ScriptResponse>> Function() get scriptVerbose => throw UnimplementedError();
}