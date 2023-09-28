import 'package:flutter/material.dart';
import 'package:yehyefirebasee/Helpers/navigator_helper.dart';
import 'package:yehyefirebasee/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with NavigatorHelper {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),() => jump(context,to: MainScreen(),replace: true),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('SPLASH'),
      ),
    );
  }
}
