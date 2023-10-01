import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sih_app/login_screen.dart';

class SettingsPage extends StatefulWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SettingsPage({super.key});
  void _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Logout",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(),
        elevation: 10.00,
        backgroundColor: Colors.blue[300],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'LOGOUT',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () => widget._signOut(context),
            style: ElevatedButton.styleFrom(
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              padding: const EdgeInsets.only(left: 50, right: 50),
            ),
            child: const Text('Logout'),
          )
        ],
      ),
    );
  }
}
