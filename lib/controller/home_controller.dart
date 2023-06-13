import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/helper/my_dialogs.dart';
import 'package:vpn_basic_project/helper/pref.dart';
import '../models/vpn.dart';
import '../models/vpn_config.dart';
import '../services/vpn_engine.dart';

class HomeController extends GetxController{
  final Rx<VPN?> vpn=Pref.vpn.obs;
  final vpnState = VpnEngine.vpnDisconnected.obs;

  Future<void> initData() async{}
  void connectToVpn() async {
    if (vpn.value!.openVPNConfigDataBase64!.isEmpty) {
      MyDialogs.info(msg: 'Select a Location by clicking \'Change Location\'');
      return;
    }

    if (vpnState.value == VpnEngine.vpnDisconnected) {
      // log('\nBefore: ${vpn.value.openVPNConfigDataBase64}');

      final data = Base64Decoder().convert(vpn.value!.openVPNConfigDataBase64??'');
      final config = Utf8Decoder().convert(data);
      final vpnConfig = VpnConfig(
          country: vpn.value!.countryLong??"Country",
          username: 'vpn',
          password: 'vpn',
          config: config);

      // log('\nAfter: $config');

      await VpnEngine.startVpn(vpnConfig);
    } else {
      await VpnEngine.stopVpn();
    }
  }
  Color get getButtonColor {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return Colors.blue;

      case VpnEngine.vpnConnected:
        return Colors.green;

      default:
        return Colors.orangeAccent;
    }
  }

  // vpn button text
  String get getButtonText {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        {log(vpnState.value);
        return 'Tap to Connect';}

      case VpnEngine.vpnConnected:
        {log(vpnState.value);
        return 'Disconnect';}

      default:
        {log(vpnState.value);
        return 'Connecting...';}
    }
  }
}