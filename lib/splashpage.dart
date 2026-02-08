import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noviindustechnologies/provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // call provider after widget build
    Future.microtask(() {
      context.read<SplashProvider>().startSplash(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          'assets/splash_img.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
