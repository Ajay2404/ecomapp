import 'package:ecommerce/dashBoard.dart';
import 'package:ecommerce/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static SharedPreferences? prefs;

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forSharePrefs();
  }

  bool isLogin = false;

  forSharePrefs() async {
    SplashScreen.prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = SplashScreen.prefs!.getBool("loginStatus") ?? false;
    });

    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (isLogin) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const DashBoard();
          },
        ));
      } else {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const LoginPage();
          },
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Lottie.asset(
        "images/lottie/shopping.json",
      )),
      backgroundColor: Colors.blue,
    );
  }
}
