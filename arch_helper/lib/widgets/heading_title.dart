import 'package:arch_helper/utils/layout_calc.dart';
import 'package:flutter/material.dart';

class HeadingTitle extends StatelessWidget {
  final String text;
  const HeadingTitle({super.key, this.text = 'Installers'});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getMenuWidth(context),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(text, style: TextStyle(fontSize: 30),)
    );
  }
}