import 'package:arch_helper/utils/classes/console_state.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

class ServiceLocator {  
  static void registerSingletons() {
    locator.registerLazySingleton<ConsoleState>(() => ConsoleState());
  }
  
  static ConsoleState get consoleState => locator<ConsoleState>();
}