import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/apis/apis.dart';
import 'package:vpn_basic_project/models/ip_details.dart';
import 'package:vpn_basic_project/models/network.dart';
import 'package:vpn_basic_project/widget/network_card.dart';

import '../main.dart';

class NetworkScreen extends StatelessWidget {
  const NetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ipData=IPDetails.fromJson({}).obs;
    APIs.getIPDetails(ipData: ipData);
    return Scaffold(
      appBar: AppBar(
        title: Text('Network Test Screen'),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 10, bottom: 10),
        child: FloatingActionButton(
          onPressed: () {
            ipData.value=IPDetails.fromJson({});
            APIs.getIPDetails(ipData: ipData);
            log(ipData.value.country.toString());
          },
          child: Icon(Icons.refresh),
        ),
      ),
      body: Obx(()=>ListView(
        padding:
        EdgeInsets.fromLTRB(mq.width * 0.04, mq.height * 0.02, mq.width * 0.04, mq.width * 0.1),
        physics: BouncingScrollPhysics(),
        children: [
          NetworkCard(
              data: Network(
                  title: 'IP Address',
                  sub: ipData.value.query.toString(),
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.blue,
                  ))),
          NetworkCard(
              data: Network(
                  title: 'Internet Provider',
                  sub: ipData.value.isp.toString(),
                  icon: Icon(
                    Icons.business_sharp,
                    color: Colors.orangeAccent,
                  ))),
          NetworkCard(
              data: Network(
                  title: 'Location',
                  sub: ipData.value.country.toString(),
                  icon: Icon(
                    CupertinoIcons.location,
                    color: Colors.pink,
                  ))),
          NetworkCard(
              data: Network(
                  title: 'Pin code',
                  sub: ipData.value.zip.toString(),
                  icon: Icon(
                    Icons.location_on_outlined,
                    color: Colors.greenAccent,
                  ))),
          NetworkCard(
              data: Network(
                  title: 'Timezone',
                  sub: ipData.value.timezone.toString(),
                  icon: Icon(
                    Icons.access_time,
                    color: Colors.green,
                  ))),
        ],
      ))
    );
  }
}
