class VPN {
  String? hostName;
  String? iP;
  int? score;
  int? ping;
  int? speed;
  String? countryLong;
  String? countryShort;
  int? numVpnSessions;
  int? uptime;
  int? totalUsers;
  int? totalTraffic;
  String? logType;
  String? operator;
  String? message;
  String? openVPNConfigDataBase64;

  VPN(
      {this.hostName,
        this.iP,
        this.score,
        this.ping,
        this.speed,
        this.countryLong,
        this.countryShort,
        this.numVpnSessions,
        this.uptime,
        this.totalUsers,
        this.totalTraffic,
        this.logType,
        this.operator,
        this.message,
        this.openVPNConfigDataBase64});

  VPN.fromJson(Map<String, dynamic> json) {
    hostName = json['HostName']??'';
    iP = json['IP']??'';
    score = json['Score']??0;
    ping = json['Ping']??0;
    speed = json['Speed']??0;
    countryLong = json['CountryLong']??'';
    countryShort = json['CountryShort']??'';
    numVpnSessions = json['NumVpnSessions']??0;
    uptime = json['Uptime']??0;
    totalUsers = json['TotalUsers']??0;
    totalTraffic = json['TotalTraffic']??0;
    logType = json['LogType']??'';
    operator = json['Operator']??'';
    message = json['Message']??'';
    openVPNConfigDataBase64 = json['OpenVPN_ConfigData_Base64']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HostName'] = this.hostName;
    data['IP'] = this.iP;
    data['Score'] = this.score;
    data['Ping'] = this.ping;
    data['Speed'] = this.speed;
    data['CountryLong'] = this.countryLong;
    data['CountryShort'] = this.countryShort;
    data['NumVpnSessions'] = this.numVpnSessions;
    data['Uptime'] = this.uptime;
    data['TotalUsers'] = this.totalUsers;
    data['TotalTraffic'] = this.totalTraffic;
    data['LogType'] = this.logType;
    data['Operator'] = this.operator;
    data['Message'] = this.message;
    data['OpenVPN_ConfigData_Base64'] = this.openVPNConfigDataBase64;
    return data;
  }
}