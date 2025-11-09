import 'dart:async';

import 'package:arch_helper/utils/classes/script_command.dart';
import 'package:arch_helper/utils/classes/script_response.dart';
import 'package:flutter/material.dart';

class ScriptButton extends StatefulWidget {
  final ScriptCommand command;
  const ScriptButton({super.key, required this.command});

  @override
  State<ScriptButton> createState() => _ScriptButtonState();
}

class _ScriptButtonState extends State<ScriptButton> {
  late Future<ScriptResponse> _openBinaryFuture = Future.sync(() {return ScriptResponse();});

  @override
  void initState() {
    if(mounted) {
      setState(() {
        _openBinaryFuture;
      });
    }
    // _openBinaryFuture = widget.command.hasBinary ? widget.command.script() : Future.sync(() {return ScriptResponse();});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(!widget.command.hasBinary) {
      return Container(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.command.scriptName), 
            TextButton(
              onPressed: () {
                if(widget.command.hasVerbose) {
                  widget.command.scriptVerbose();
                } else {
                  widget.command.script();
                }
              }, 
              child: Row(children: [Text('Start Script'), Icon(Icons.play_arrow)],)
            ),
          ],
        ),
      );
    }
    return FutureBuilder(future: _openBinaryFuture, builder: (context, asyncSnapshot) {
      debugPrint(asyncSnapshot.connectionState.toString());
      debugPrint(asyncSnapshot.data?.successful.toString());
      if(asyncSnapshot.connectionState == ConnectionState.none || asyncSnapshot.connectionState == ConnectionState.done) {
        return Container(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.command.scriptName), 
              TextButton(
                onPressed: () {
                  if(mounted) {
                    if(widget.command.hasVerbose) {
                      widget.command.scriptVerbose();
                    } else {
                      setState(() {
                        _openBinaryFuture = widget.command.script();
                      });
                    }
                  }
                }, 
                child: Row(children: [Text('Start Script'), Icon(Icons.play_arrow)],)
              ),
            ],
          ),
        );
      }
      if(asyncSnapshot.connectionState == ConnectionState.active || asyncSnapshot.connectionState == ConnectionState.waiting) {
        return Container(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.command.scriptName), 
              TextButton(
                onPressed: () {
                  widget.command.runExecArg(executable: 'killall', arguments: [widget.command.binaryName ?? '']);
                }, 
                child: Row(children: [Text('Stop Script'), Icon(Icons.stop)],)
              ),
            ],
          ),
        );
      }
      return ErrorWidget(UnimplementedError);
    });
  }
}

