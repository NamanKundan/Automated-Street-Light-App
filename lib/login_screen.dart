import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sih_app/The_first_page_(navbar).dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  void _signInWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        // Successful login, navigate to the home screen.
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => TheFirstPage(),
        ));
      } catch (e) {
        // Handle login errors, e.g., display an error message.
        print("Error: $e");
        if (e is FirebaseAuthException) {
          if (e.code == 'wrong-password') {
            // Password is incorrect, show a Snackbar.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Incorrect password. Please try again."),
              ),
            );
            return; // Stop execution here to prevent navigating to HomeScreen.
          }
        }
        // For other errors, show a generic error message.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("An error occurred. Please try again later."),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: 30),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.alternate_email),
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Password',
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _signInWithEmailAndPassword,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                  padding: const EdgeInsets.only(left: 50, right: 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
