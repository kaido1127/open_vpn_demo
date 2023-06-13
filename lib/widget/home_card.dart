import 'package:flutter/material.dart';
import 'package:vpn_basic_project/main.dart';

class HomeCard extends StatelessWidget {
  final String title, subtitle;
  final Widget icon;
  const HomeCard({required this.title, required this.subtitle, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mq.width*.45,
      child: Column(
        children: [
          icon,
          SizedBox(height: 6,),
          Text(title,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
          SizedBox(height: 6,),
          Text(subtitle,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Theme.of(context).lightText),),
        ],
      ),
    );
  }
}
