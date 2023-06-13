import 'dart:developer';
import 'package:get/get.dart';
import 'package:vpn_basic_project/apis/apis.dart';
import '../models/vpn.dart';

class LocationController extends GetxController{
  List<VPN> vpnList=[];

  final RxBool isLoading=false.obs;

  Future<void> getVpnData() async{
    log("isloading");
    isLoading.value=true;
    vpnList.clear();
    vpnList=await APIs.getVPNSevers();
    log("loading sucess");
    isLoading.value=false;
  }
}