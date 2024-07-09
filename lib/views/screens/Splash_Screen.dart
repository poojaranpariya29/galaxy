import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/controllers/providers/json_decode_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  loadData() async {
    await Provider.of<JsonDecodeProvider>(context, listen: false).loadJson();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 4),
      () {
        Navigator.of(context).pushReplacementNamed('home_page');
      },
    );

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/gifs/splash.gif',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
