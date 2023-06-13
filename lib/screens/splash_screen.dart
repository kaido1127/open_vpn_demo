import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';
import 'package:get/route_manager.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(milliseconds: 2000),(){
      //SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      Get.off(()=>HomeScreen());
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: mq.height * 0.3,
              left: mq.width * .3,
              width: mq.width * .4,
              child: Image.asset('assets/images/vpn.png')),
          Positioned(
              width: mq.width,
              bottom: mq.height * .15,
              child:  Text(
                'NTV 2023',
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).lightText),
              ))
        ],
      ),
    );
  }
}
