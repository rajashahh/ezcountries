import 'package:ezcountry/common/constants.dart';
import 'package:ezcountry/providers/homepage_provider.dart';
import 'package:ezcountry/screens/country_details.dart';
import 'package:ezcountry/screens/home_page.dart';
import 'package:ezcountry/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HomepageProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        routes: {
          Constants.splashPath: (context) => const SplashScreen(),
          Constants.homePath: (context) => const HomePage(),
          Constants.countryDetailsPath: (context) => const CountryDetails(),
        },
        initialRoute: Constants.splashPath,
      ),
    );
  }
}
