
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vpn_basic_project/controller/home_controller.dart';
import 'package:vpn_basic_project/helper/pref.dart';
import 'package:vpn_basic_project/screens/location_screen.dart';
import 'package:vpn_basic_project/screens/network_screen.dart';
import 'package:vpn_basic_project/widget/count_down_timer.dart';
import 'package:vpn_basic_project/widget/home_card.dart';
import 'package:vpn_basic_project/main.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.home,
          size: 30,
        ),
        title: const Text('OpenVPN Demo'),
        actions: [
          IconButton(onPressed: () {
            Get.changeThemeMode(Pref.isDarkMode?ThemeMode.light:ThemeMode.dark);
            Pref.isDarkMode=!Pref.isDarkMode;
          }, icon: const Icon(Icons.brightness_medium)),
          IconButton(
              padding: const EdgeInsets.only(right: 10),
              onPressed: () {
                Get.to(NetworkScreen());
              },
              icon: const Icon(Icons.info))
        ],
      ),
      bottomNavigationBar: _changeLoaction(context),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Obx(() => _vpnButton()),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeCard(
                  title: _controller.vpn.value!.countryLong!.isEmpty
                      ? 'Country'
                      : _controller.vpn.value!.countryLong.toString(),
                  subtitle: 'FREE',
                  icon: CircleAvatar(
                    radius: 30,
                    child: _controller.vpn.value!.countryLong!.isEmpty
                        ? Icon(
                            Icons.vpn_lock_rounded,
                            size: 30,
                            color: Colors.white,
                          )
                        : null,
                    backgroundImage: _controller.vpn.value!.countryLong!.isEmpty
                        ? null
                        : AssetImage(
                            'assets/flags/${_controller.vpn.value?.countryShort?.toLowerCase()}.png'),
                  ),
                ),
                HomeCard(
                  title: _controller.vpn.value!.countryLong!.isEmpty
                      ? '100 ms'
                      : '${_controller.vpn.value?.ping} ms',
                  subtitle: 'PING',
                  icon: const CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 30,
                    child: Icon(
                      Icons.bar_chart,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )),
        StreamBuilder<VpnStatus?>(
            initialData: VpnStatus(),
            stream: VpnEngine.vpnStatusSnapshot(),
            builder: (context, snapshot) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HomeCard(
                    title: '${snapshot.data?.byteIn ?? '0 kbps'}',
                    subtitle: 'DOWNLOAD',
                    icon: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.file_download,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  HomeCard(
                    title: '${snapshot.data?.byteOut ?? '0 kbps'}',
                    subtitle: 'UPLOAD',
                    icon: const CircleAvatar(
                      backgroundColor: Colors.lightBlue,
                      radius: 30,
                      child: Icon(
                        Icons.upload,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              );
            }),
      ]),
    );
  }

  Widget _vpnButton() {
    return Column(
      children: [
        Semantics(
          button: true,
          child: InkWell(
            onTap: () {
              _controller.connectToVpn();
              //APIs.getVPNSevers();
            },
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _controller.getButtonColor.withOpacity(.1),
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _controller.getButtonColor.withOpacity(.3),
                ),
                child: Container(
                  width: mq.height * .14,
                  height: mq.height * .14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _controller.getButtonColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //icon
                      Icon(
                        Icons.power_settings_new,
                        size: 28,
                        color: Colors.white,
                      ),

                      SizedBox(height: 4),

                      //text
                      Text(
                        _controller.getButtonText,
                        style: TextStyle(
                            fontSize: 12.5, color: Colors.white, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin:
          EdgeInsets.only(top: mq.height * .015, bottom: mq.height * .02),
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(15)),
          child: Text(
            _controller.vpnState.value == VpnEngine.vpnDisconnected
                ? 'Not Connected'
                : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
            style: TextStyle(fontSize: 12.5, color: Colors.white),
          ),
        ),
        Obx(
          () => CountDownTimer(startTimer:  _controller.vpnState.value==VpnEngine.vpnConnected),
        ),
      ],
    );
  }

  Widget _changeLoaction(BuildContext context) {
    return SafeArea(
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: () {
            Get.to(LocationScreen());
          },
          child: Container(
            height: 60,
            color: Theme.of(context).bottomNavColor,
            padding: EdgeInsets.symmetric(horizontal: mq.width * 0.04),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.globe,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Change Location',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
