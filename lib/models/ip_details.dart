class IPDetails {
  String? query;
  String? status;
  String? country;
  String? countryCode;
  String? region;
  String? regionName;
  String? city;
  String? zip;
  double? lat;
  double? lon;
  String? timezone;
  String? isp;
  String? org;
  String? as;

  IPDetails(
      {this.query,
        this.status,
        this.country,
        this.countryCode,
        this.region,
        this.regionName,
        this.city,
        this.zip,
        this.lat,
        this.lon,
        this.timezone,
        this.isp,
        this.org,
        this.as});

  IPDetails.fromJson(Map<String, dynamic> json) {
    query = json['query']??'Not available';
    status = json['status']??'';
    country = json['country']??'Fetching....';
    countryCode = json['countryCode']??'';
    region = json['region']??'';
    regionName = json['regionName']??'';
    city = json['city']??'';
    zip = json['zip']??' - - - - ';
    lat = json['lat']??0;
    lon = json['lon']??0;
    timezone = json['timezone']??'Unknown';
    isp = json['isp']??'Unknown';
    org = json['org']??'';
    as = json['as']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['query'] = this.query;
    data['status'] = this.status;
    data['country'] = this.country;
    data['countryCode'] = this.countryCode;
    data['region'] = this.region;
    data['regionName'] = this.regionName;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['timezone'] = this.timezone;
    data['isp'] = this.isp;
    data['org'] = this.org;
    data['as'] = this.as;
    return data;
  }
}