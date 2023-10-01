import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sih_app/login_screen.dart';
import 'package:sih_app/pages/alert_pages.dart';
import 'package:sih_app/pages/monitoring_page.dart';
import 'package:sih_app/pages/overview_page.dart';
import 'package:sih_app/pages/setting.dart';

class TheFirstPage extends StatefulWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TheFirstPage({super.key});
  void _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  State<TheFirstPage> createState() => _TheFirstPageState();
}

class _TheFirstPageState extends State<TheFirstPage> {
  int selectedPage = 0;

  final _pageOptions = [
    const OverviewPage(),
    const AlertPage(),
    const MonitoringPage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.logout),
      //     onPressed: () => widget._signOut(context),
      //   ),
      // ],
      backgroundColor: Colors.white,
      body: _pageOptions[selectedPage],
      bottomNavigationBar:
          // HomePage(),
          BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.crisis_alert_sharp),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_outlined),
            label: 'Monitoring',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.blue[300],
        elevation: 5.0,
        unselectedItemColor: Colors.white,
        currentIndex: selectedPage,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
