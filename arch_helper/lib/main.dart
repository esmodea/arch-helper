import 'package:arch_helper/utils/classes/service_locator.dart';
import 'package:arch_helper/widgets/installers_widgets/installers_menu.dart';
import 'package:arch_helper/widgets/scripts_widgets/scripts_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

void main() {
  ServiceLocator.registerSingletons();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late List<String> logText;
  int index = 0;

  @override
  void initState() {
    logText = [];
    ServiceLocator.consoleState.loggerStream.stream.listen((event) {
      debugPrint('listening to stream sanity check');
      setState(() {
        logText = [...logText, ...event];
      });
    }, cancelOnError: false, onDone: () {
      debugPrint('listening to stream done');
    }, onError: (e) {
      debugPrint('$e listening to stream error');
    });
    if(mounted) {
      setState(() {
        logText;
        index;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logText.map((e) {
      debugPrint(e);
      return e;
    });
    debugPrint(logText.length.toString());
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  if(mounted) {
                    setState(() {
                      index = 0;
                    });
                  }
                },
                icon: Icon(
                  Icons.install_desktop
                ),
              ),
              IconButton(
                onPressed: () {
                  if(mounted) {
                    setState(() {
                      index = 1;
                    });
                  }
                },
                icon: Icon(
                  Icons.output,
                ),
              ),
            ],
          ),
        ),
        body: LazyLoadIndexedStack(
          preloadIndexes: [0, 1],
          index: index,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: InstallersMenu(),
                ),
                Container(
                  height: 44,
                  width: 2,
                  color: Colors.black,
                ),
                SingleChildScrollView(
                  child: ScriptsMenu(),
                ),
              ],
            ),
            Container(
              height: MediaQuery.heightOf(context) - 56,
              width: MediaQuery.widthOf(context),
              padding: EdgeInsets.all(5),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black87,
                ),
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        ...logText.map((text) {
                          return Text(text, style: TextStyle(color: Colors.white),);
                        }),
                        ...ServiceLocator.consoleState.releaseLogs.map((text) {
                          return Text(text, style: TextStyle(color: Colors.white),);
                        }),
                      ],
                    ),
                    Positioned(
                      left: 2,
                      child: IconButton(
                        onPressed: () {
                          //TODO: fix for release mode
                          Clipboard.setData(ClipboardData(text: logText.join('\n')));
                        }, 
                        icon: Icon(Icons.copy, color: Colors.white,)
                      )
                    ),
                    Positioned(
                      left: 42,
                      child: IconButton(
                        onPressed: () {
                          //TODO: fix for release mode
                          ServiceLocator.consoleState.togglePrettyPrinter();
                          if(mounted) {
                            setState(() {
                              logText = [];
                            });
                          }
                        }, 
                        icon: Icon(Icons.star, color: Colors.white,)
                      )
                    ),
                    Positioned(
                      right: 2,
                      child: IconButton(
                        onPressed: () {
                          //TODO: fix for release mode
                          if(mounted) {
                            setState(() {
                              logText = [];
                            });
                          }
                        }, 
                        icon: Icon(Icons.delete, color: Colors.white,)
                      )
                    )
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
