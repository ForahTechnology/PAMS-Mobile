//AUTHOR: EWANFO LUCKY PETER

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constants {
  //ADD MORE BASE_URL AND EDIT API_SUB_ENPOINT IF API CHANGES IN FUTURE
  static const String base_url = "http://sethlab-001-site1.itempurl.com/api/v1";


  static const String googleKey = 'AIzaSyCXbx6asbtvpllrqfmWEmhnoQUUbQnIKrE';

  //PAYMENT
  static const String paystackKey =
      "pk_test_25e249297133695de0f477d314a9d2658c967446";
  // "pk_live_4b19d7a93a939e8b2937cef7e609a1bc18cb3dee";

  static bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  static String getPaymentReference() {
    final String alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    var time = DateTime.now();
    final String characters = "0123456789$alpha${time.millisecondsSinceEpoch}";
    var rnd = new Random();
    // Format "ED{16 RANDOM CHARACTERS}{MINUTE_SECOND}{TWO RANDOM LETTERS}"

    var sb = new StringBuffer('ED');
    for (int i = 0; i < 16; i++) {
      sb.write(characters[(rnd.nextInt(characters.length))]);
    }
    sb.write('${time.minute}${time.second}');
    for (int i = 0; i < 2; i++) {
      sb.write(alpha[(rnd.nextInt(alpha.length))]);
    }
    return sb.toString();
  }
   Future notify(String msg)async{
     return  Fluttertoast.showToast(
                          msg: msg,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
   }
 
}
