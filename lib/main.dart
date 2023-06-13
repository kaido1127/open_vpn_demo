import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vpn_basic_project/helper/pref.dart';
import 'package:vpn_basic_project/screens/splash_screen.dart';
import 'screens/home_screen.dart';

late Size mq;

Future<void> main() async {
  await Pref.initHive();
  /*SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]).then((value) => );*/
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(centerTitle: true,elevation: 10),
      ),
      theme: ThemeData(
        appBarTheme: AppBarTheme(centerTitle: true,elevation: 10),
      ),
      themeMode: Pref.isDarkMode?ThemeMode.dark:ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'OpenVpn Demo',
      home: SplashScreen(),
    );
  }
}

extension AppTheme on ThemeData{
  Color get lightText=> Get.isDarkMode?Colors.white70:Colors.black54;
  Color? get bottomNavColor=>Get.isDarkMode?Colors.grey[800]:Colors.blue;
}