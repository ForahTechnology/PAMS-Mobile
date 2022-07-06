import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pams/authentication/auth.dart';
import 'package:pams/screens/homepage.dart';
import 'package:pams/screens/splashScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((val) {
    runApp(ProviderScope(child: MyApp()));
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _transitionToNextPageAfterSplash();
  }

  String? token;
  _transitionToNextPageAfterSplash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('apiToken');
    });

  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 700),
        builder: () => MaterialApp(
              theme: ThemeData(fontFamily: 'Rubik-Medium'),
              debugShowCheckedModeBanner: false,
              home:  AuthPage() 
            ));
  }
}
