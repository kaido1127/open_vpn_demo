import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/controller/location_controller.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/widget/vpn_card.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({super.key});
  final _controller = LocationController();

  @override
  Widget build(BuildContext context) {
    if(_controller.vpnList.isEmpty) _controller.getVpnData();
    return Obx(() => Scaffold(
      appBar: AppBar(
        title: Text("VPN Locations(${_controller.vpnList.length})"),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding:  EdgeInsets.only(right: 10,bottom: 10),
        child: FloatingActionButton(
          onPressed: (){_controller.getVpnData();},
          child: Icon(Icons.refresh),
        ),
      ),
      body: _controller.isLoading.value
          ? _loadingWidget(context)
          : _controller.vpnList.isEmpty
          ? _noVPNFound(context)
          : _vpnData(context),
    ));
  }

  _vpnData(BuildContext context) => ListView.builder(
    padding: EdgeInsets.fromLTRB(mq.width*0.04, mq.height*0.02, mq.width*0.04, mq.width*0.1),
      itemCount: _controller.vpnList.length,
      itemBuilder: (context, index) {
        return VpnCard(vpn: _controller.vpnList[index]);
      });

  _loadingWidget(BuildContext context) => SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/lottie/loading.json", width: mq.width * 0.4),
            Text(
              'Loading...',
              style: TextStyle(color: Theme.of(context).lightText, fontWeight: FontWeight.w500, fontSize: 18),
            )
          ],
        ),
      );

  _noVPNFound(BuildContext context) => Center(
          child: Text(
        'Sorry, VPNs Not Found',
        style: TextStyle(color: Theme.of(context).lightText, fontWeight: FontWeight.w500, fontSize: 18),
      ));
}
