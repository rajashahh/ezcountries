import 'package:ezcountry/common/colors.dart';
import 'package:ezcountry/common/constants.dart';
import 'package:ezcountry/common/dimensions.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() async {
    Future.delayed(const Duration(seconds: Dimensions.dimensionInt3), () {
      Navigator.pushReplacementNamed(context, Constants.homePath);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Constants.splashIconPath,
                width: Dimensions.dimension_100,
              ),
              const SizedBox(
                height: Dimensions.dimension_10,
              ),
              Text(
                "${Constants.appName} ${Constants.app}",
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: Dimensions.dimension_20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
