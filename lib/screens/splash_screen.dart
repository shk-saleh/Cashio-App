import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // or your main navigation screen
import 'package:cashio/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait 3 seconds, then navigate to home
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
          MaterialPageRoute(builder: (context) => const MainPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF5D5A5),
              Color(0xFFFFF3E1),
              Color(0xFFFFFFFF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/app-logo.png',
            width: 180,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
