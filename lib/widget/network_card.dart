import 'package:flutter/material.dart';
import 'package:vpn_basic_project/models/network.dart';

import '../main.dart';

class NetworkCard extends StatelessWidget {
  final Network data;
  const NetworkCard({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: mq.height*0.01),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: (){},
        borderRadius: BorderRadius.circular(15),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          leading: Icon(data.icon.icon,size: data.icon.size??28,color: data.icon.color,),
          title: Text(data.title, style: TextStyle(),),
          subtitle: Text(data.sub, style: TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
