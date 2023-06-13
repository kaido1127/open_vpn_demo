import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controller/home_controller.dart';
import 'package:vpn_basic_project/helper/my_dialogs.dart';
import 'package:vpn_basic_project/helper/pref.dart';
import 'package:vpn_basic_project/models/vpn.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart';

import '../main.dart';

class VpnCard extends StatelessWidget {
  final VPN vpn;
  const VpnCard({required this.vpn, super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.find<HomeController>();
    return Card(
      margin: EdgeInsets.symmetric(vertical: mq.height*0.01),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: (){
          controller.vpn.value=vpn;
          Pref.vpn=vpn;
          Get.back();
          MyDialogs.sucess(msg: 'Connecting....');
          if(controller.vpnState.value==VpnEngine.vpnConnected){
            VpnEngine.stopVpn();
            Future.delayed(Duration(seconds: 2),(){
              controller.connectToVpn();
            });
          }else{
            controller.connectToVpn();
          }

        },
        borderRadius: BorderRadius.circular(15),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          leading: Container(
            padding: EdgeInsets.all(0.5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(5),
            ),
              child: ClipRRect(
                child: Image.asset(
            'assets/flags/${vpn.countryShort?.toLowerCase()}.png',
            width: mq.width*0.15,
            fit: BoxFit.cover,
          ),
              )),
          title: Text(
            vpn.countryLong.toString(),
            style: TextStyle(),
          ),
          subtitle: Row(
            children: [
              Icon(
                Icons.speed,
                color: Colors.blue,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                formatBytes(vpn.speed!.toInt()),
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vpn.numVpnSessions.toString(),
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Theme.of(context).lightText),
              ),
              SizedBox(
                width: 4,
              ),
              Icon(
                Icons.people_outline,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
  String formatBytes(int bytes) {
    if (bytes <= 0) return "0 B";

    const units = ['Bps', 'Kbps', 'Mbps', 'Gbps', 'Tbps'];
    final doubleValue = bytes.toDouble();
    int unitIndex = (doubleValue > 0) ? (log(doubleValue) / log(1024)).floor() : 0;
    double value = doubleValue / pow(1024, unitIndex);
    value = double.parse(value.toStringAsFixed(2));

    return '$value ${units[unitIndex]}';
  }

}
