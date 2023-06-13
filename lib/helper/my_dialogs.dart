import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialogs {
  static sucess({required String msg}) {
    Get.snackbar('Success', msg,
        colorText: Colors.white, backgroundColor: Colors.blue.withOpacity(0.8));
  }

  static error({required String msg}) {
    Get.snackbar('Error', msg,
        colorText: Colors.white, backgroundColor: Colors.red.withOpacity(0.8));
  }

  static info({required String msg}) {
    Get.snackbar('Info', msg, colorText: Colors.white);
  }
}
