import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pams/providers/auth_provider.dart';
import 'package:pams/providers/clients_data_provider.dart';
import 'package:pams/utils/images.dart';
import 'package:pams/views/authentication/auth.dart';
import 'package:pams/views/homepage.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  GetStorage box = GetStorage();
  @override
  void initState() {
    _transitionToNextPageAfterSplash();
    super.initState();
    // _determinePosition();
  }

  _transitionToNextPageAfterSplash() async {
    var token = box.read('token');
    return Timer(
      Duration(
        seconds: 1,
      ),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => token == null ? AuthPage() : HomeView(),
        ),
      ),
    );
  }

  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   return await Geolocator.getCurrentPosition();
  // }

  @override
  Widget build(BuildContext context) {
    var _authViewModel = ref.watch(authViewModel);
    var _clientViewmodel = ref.watch(clientViewModel);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            width: 350,
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(appLogoIcon),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
