import 'package:flutter/material.dart';

import 'package:smarterchat/pages/splash.dart';

class SmarterChat extends StatelessWidget {
  const SmarterChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(
          255,
          19,
          93,
          116,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
