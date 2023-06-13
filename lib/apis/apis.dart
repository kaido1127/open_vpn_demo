import 'dart:convert';
import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:vpn_basic_project/helper/my_dialogs.dart';
import 'package:vpn_basic_project/helper/pref.dart';
import 'package:vpn_basic_project/models/ip_details.dart';
import 'package:vpn_basic_project/models/vpn.dart';

class APIs{
  static Future<List<VPN>> getVPNSevers() async {
    final List<VPN> vpnList = [];

    try {
      final res = await get(Uri.parse('http://www.vpngate.net/api/iphone/'));
      final csvString = res.body.split("#")[1].replaceAll('*', '');

      List<List<dynamic>> list = const CsvToListConverter().convert(csvString);

      final header = list[0];

      for (int i = 1; i < list.length - 1; ++i) {
        Map<String, dynamic> tempJson = {};

        for (int j = 0; j < header.length; ++j) {
          tempJson.addAll({header[j].toString(): list[i][j]});
        }
        vpnList.add(VPN.fromJson(tempJson));
      }
    } catch (e) {
      MyDialogs.error(msg: e.toString());
    }
    vpnList.shuffle();
    if(vpnList.isNotEmpty){
      Pref.vpnList=vpnList;
    }
    return vpnList;
  }
  static Future<void> getIPDetails({required Rx<IPDetails> ipData}) async {
    try {
      final res = await get(Uri.parse('http://ip-api.com/json/'));
      ipData.value = IPDetails.fromJson(jsonDecode(res.body));
    } catch (e) {
      MyDialogs.error(msg: e.toString());
      log('$e');
    }
  }


}