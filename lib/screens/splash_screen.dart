import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
void initState() {
  super.initState();
  _authenticateUser();
}

Future<void> _authenticateUser() async {
  final auth = AuthService();

  bool success = await auth.authenticate();

  if (success) {
    Navigator.pushReplacementNamed(context, '/home');
  } else {
    // fallback
    Navigator.pushReplacementNamed(context, '/home');
  }
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: const [

            Icon(Icons.restaurant, size: 80, color: Colors.white),

            SizedBox(height: 20),

            Text(
              "Campus Food Finder",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}