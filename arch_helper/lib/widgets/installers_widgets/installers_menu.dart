// import 'package:arch_helper/utils/installers/cups_installer.dart';
// import 'package:arch_helper/utils/installers/pavucontrol_installer.dart';
import 'package:arch_helper/utils/installers/dolphin_installer.dart';
import 'package:arch_helper/utils/installers/steam_installer.dart';
import 'package:arch_helper/utils/installers/update_packages.dart';
import 'package:arch_helper/utils/installers/vivaldi_installer.dart';
import 'package:arch_helper/utils/layout_calc.dart';
import 'package:arch_helper/widgets/installers_widgets/installer_button.dart';
import 'package:flutter/material.dart';
import 'package:arch_helper/widgets/heading_title.dart';

class InstallersMenu extends StatelessWidget {
  const InstallersMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyanAccent,
      width: getMenuWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeadingTitle(),
          InstallerButton(command: UpdatePackages()),
          InstallerButton(command: VivaldiInstaller()),
          InstallerButton(command: SteamInstaller()),
          InstallerButton(command: DolphinInstaller()),
        ],
      ),
    );
  }
}
