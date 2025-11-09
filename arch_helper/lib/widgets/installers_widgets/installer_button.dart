import 'package:arch_helper/utils/classes/installer_command.dart';
import 'package:flutter/material.dart';

class InstallerButton extends StatefulWidget {
  final InstallerCommand command;
  const InstallerButton({super.key, required this.command});

  @override
  State<InstallerButton> createState() => _InstallerButtonState();
}

class _InstallerButtonState extends State<InstallerButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.command.installerName), 
          TextButton(
            onPressed: () {
              if(widget.command.hasVerbose) {
                widget.command.scriptVerbose();
              } else {
                widget.command.script();
              }
            }, 
            child: Row(children: [Text('Start Install'), Icon(Icons.play_arrow)],)
          ),
        ],
      ),
    );
  }
}

