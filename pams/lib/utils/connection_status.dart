import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pams/utils/controller.dart';

class ConnectionStatus {
  static Future<bool> isConnected(BuildContext context) async {
    var connectionResult = await (Connectivity().checkConnectivity());

    if (connectionResult == ConnectivityResult.mobile)
      return true;
    else if (connectionResult == ConnectivityResult.wifi)
      return true;
    else {
      Fluttertoast.showToast(msg: "Check Network Connection !!!");
      return false;
    }
  }

  static Future<void> update() async {
    PamsStateController controller = Get.put<PamsStateController>(PamsStateController());
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (!controller.connectionStatus.value) {
          Fluttertoast.showToast(msg: "Internet connection detected.");
          controller.connectionStatus.value = true;
          // SynchronizeData.init();
        }
      } else {
        if (controller.connectionStatus.value) {
          Fluttertoast.showToast(msg: "You're currently offline.");
          controller.connectionStatus.value = false;
        }
      }
    } on SocketException catch (_) {
      if (controller.connectionStatus.value) {
        Fluttertoast.showToast(msg: "You're currently offline.");
        controller.connectionStatus.value = false;
      }
    } catch (e) {
      if (controller.connectionStatus.value) {
        Fluttertoast.showToast(msg: "You're currently offline.");
        controller.connectionStatus.value = false;
      }
    }
  }
}
