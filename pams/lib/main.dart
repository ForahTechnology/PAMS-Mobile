import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pams/views/clients/location/client_location.dart';
import 'package:pams/views/onboarding/splashScreen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then(
    (val) {
      runApp(
        ProviderScope(
          child: MyApp(),
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 700),
      builder: () => GetMaterialApp(
        routes: {'/clientLocation': (context) => ClientLocation()},
        theme: ThemeData(fontFamily: 'Rubik-Medium'),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
