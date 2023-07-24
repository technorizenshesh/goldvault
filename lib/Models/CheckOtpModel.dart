class CheckOtpModel {
  String status;
  String message;
  List<CheckOtpResult> result;

  CheckOtpModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory CheckOtpModel.fromJson(Map<String, dynamic> json) => CheckOtpModel(
    status: json["status"],
    message: json["message"],
    result: List<CheckOtpResult>.from(json["result"].map((x) => CheckOtpResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class CheckOtpResult {
  String id;
  String userName;
  String countryCode;
  String mobile;
  String password;
  String address;
  String lat;
  String lon;
  DateTime dateTime;
  String email;
  String token;
  String otp;

  CheckOtpResult({
    required this.id,
    required this.userName,
    required this.countryCode,
    required this.mobile,
    required this.password,
    required this.address,
    required this.lat,
    required this.lon,
    required this.dateTime,
    required this.email,
    required this.token,
    required this.otp,
  });

  factory CheckOtpResult.fromJson(Map<String, dynamic> json) => CheckOtpResult(
    id: json["id"],
    userName: json["user_name"],
    countryCode: json["country_code"],
    mobile: json["mobile"],
    password: json["password"],
    address: json["address"],
    lat: json["lat"],
    lon: json["lon"],
    dateTime: DateTime.parse(json["date_time"]),
    email: json["email"],
    token: json["token"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_name": userName,
    "country_code": countryCode,
    "mobile": mobile,
    "password": password,
    "address": address,
    "lat": lat,
    "lon": lon,
    "date_time": dateTime.toIso8601String(),
    "email": email,
    "token": token,
    "otp": otp,
  };
}
