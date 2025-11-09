import 'package:arch_helper/utils/layout_calc.dart' show getMenuWidth;
import 'package:arch_helper/utils/scripts/create_headphone_splitter.dart';
import 'package:arch_helper/utils/scripts/open_pavucontrol.dart';
import 'package:arch_helper/utils/scripts/remove_headphone_splitter.dart';
import 'package:arch_helper/utils/scripts/example_script.dart';
import 'package:arch_helper/widgets/heading_title.dart' show HeadingTitle;
import 'package:arch_helper/widgets/scripts_widgets/script_button.dart';
import 'package:flutter/material.dart';

class ScriptsMenu extends StatelessWidget {
  const ScriptsMenu({super.key});

  @override
 
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyanAccent,
      width: getMenuWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeadingTitle(text: 'Scripts',),
          ScriptButton(command: ExampleScript()),
          ScriptButton(command: CreateHeadphoneSplitter()),
          ScriptButton(command: RemoveHeadphoneSplitter()),
          ScriptButton(command: ConfigureAudio()),
        ],
      ),
    );
  }
}