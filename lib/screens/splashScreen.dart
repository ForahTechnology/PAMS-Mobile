import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pams/authentication/auth.dart';
import 'package:pams/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _transitionToNextPageAfterSplash();
    super.initState();
    _determinePosition();
  }

  _transitionToNextPageAfterSplash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiToken');
    return Timer(
      Duration(
        seconds: 3,
      ),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => token == null ? AuthPage() : HomeView(),
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
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
                image: AssetImage("assets/logoo.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
