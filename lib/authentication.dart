import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sih_app/The_first_page_(navbar).dart';
import 'package:sih_app/login_screen.dart';

class AuthenticationWrapper extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading indicator while checking the user's login state.
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          // User is logged in, show the home screen.
          return TheFirstPage();
        } else {
          // User is not logged in, show the login screen.
          return const LoginScreen();
        }
      },
    );
  }
}
