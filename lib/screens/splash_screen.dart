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
    _startApp();
  }

  Future<void> _startApp() async {

    await Future.delayed(const Duration(seconds: 1));

    final auth = AuthService();
    bool success = await auth.authenticate();

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: Center(
        child: Text(
          "Campus Food App",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}