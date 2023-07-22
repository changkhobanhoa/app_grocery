import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_flutter/pages/dashboard_page.dart';

import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, this.defaf});

  final String? defaf;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
        reverseCurve: Curves.bounceIn);
    _animationController.forward();
    Timer(
        const Duration(milliseconds: 7000),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => widget.defaf != null
                    ? const DashboardPage()
                    : const LoginPage())));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: Scaffold(
        backgroundColor: Colors.green.shade400,
        body: Center(
          child: ScaleTransition(
              scale: _animation,
              child: Image.asset(
                "assets/logo.png",
                excludeFromSemantics: true,
                filterQuality: FilterQuality.high,
                 
              )),
      
        ),
      ),
    );
  }
}
