import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarterchat/pages/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1500), () {}).then((value) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
          colors: [
            Theme.of(context).primaryColor.withOpacity(.7),
            Theme.of(context).primaryColor
          ],
        ),
      ),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text('SmarterChat',
            style: GoogleFonts.hurricane(color: Colors.white, fontSize: 60)),
      ),
    ));
  }
}
