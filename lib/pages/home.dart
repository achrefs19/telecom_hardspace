import 'package:f/components/flat_button.dart';
import 'package:f/constants.dart';
import 'package:f/pages/computers_page.dart';
import 'package:f/pages/reclaim_page.dart';
import 'package:f/services/auth_service.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: _getAppBar(),
      pane: _getNavigation(),
    );
  }

  _getAppBar(){
    return NavigationAppBar(
        title: const Text(
          'Telecom HardSpace',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        actions: Row(
          children: [
            Spacer(),
            FlatButton(onPressed: () => _firebaseAuthService.signOut(), icon: Icons.logout, txt: "Logout",backGroundColor: primaryColor,)
          ],
        )
    );
  }

  _getNavigation() {
    return NavigationPane(
      header: const FlutterLogo(
        style: FlutterLogoStyle.horizontal,
        size: 100,
      ),
        selected: selectedIndex,
        onChanged: (index){
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          PaneItemExpander(icon: const Icon(FluentIcons.pc1), title: const Text('Equipments'),body: const Center(child: Text("ss")),items: [
            PaneItem(icon: const Icon(FluentIcons.laptop_secure), title: const Text('Laptops'),body: ComputerPage()),
            PaneItem(icon: const Icon(FluentIcons.pc1), title: const Text('Desktops'),body: ComputerPage())
          ]),
          PaneItem(icon: const Icon(FluentIcons.comment), title: const Text('Reclamations'),body: ReclaimPage())

        ]
    );
  }
}
