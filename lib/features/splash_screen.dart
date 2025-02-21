import 'dart:async';
import 'package:firebase_example/features/auth/login_screen.dart';
import 'package:firebase_example/features/home/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/providers/id_provider.dart';
import '../core/widgets/Animated_Splash/animated_splash.dart';
import '../core/widgets/Animated_Splash/page_transition_type.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> documentId;
  late String docId = '';

  @override
  void initState() {
    super.initState();
    context.read<IdProvider>().getDocId();

    documentId = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('userid') ?? '';
    }).then((String value) {
      setState(() {
        docId = value;
      });
      return docId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: AnimatedSplashScreen(
        backgroundColor: Colors.transparent,
        splashIconSize: 300,
        duration: 1500,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.rightToLeftWithFade,
        splash: Center(
          child: Text(
            "Firebase",
            style: TextStyle(
              fontSize: 40,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 2.5,
            ),
          ),
        ),
        nextScreen:
            docId != '' ? const BottomNavigationScreen() : const LoginScreen(),
      ),
    );
  }
}
