class AddRedeemModel {
  String status;
  String message;
  AddRedeemModelResult result;

  AddRedeemModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory AddRedeemModel.fromJson(Map<String, dynamic> json) => AddRedeemModel(
    status: json["status"],
    message: json["message"],
    result: AddRedeemModelResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result.toJson(),
  };
}

class AddRedeemModelResult {
  String id;
  String userName;
  String email;
  String password;
  String mobile;
  String token;
  String otp;
  String address;
  String lat;
  String lon;
  DateTime dateTime;
  String countryCode;
  String country;
  String city;
  String image;
  String status;
  String goldWallet;
  String amountWallet;
  String referralCode;
  String otherReferralCode;

  AddRedeemModelResult({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.mobile,
    required this.token,
    required this.otp,
    required this.address,
    required this.lat,
    required this.lon,
    required this.dateTime,
    required this.countryCode,
    required this.country,
    required this.city,
    required this.image,
    required this.status,
    required this.goldWallet,
    required this.amountWallet,
    required this.referralCode,
    required this.otherReferralCode,
  });

  factory AddRedeemModelResult.fromJson(Map<String, dynamic> json) => AddRedeemModelResult(
    id: json["id"],
    userName: json["user_name"],
    email: json["email"],
    password: json["password"],
    mobile: json["mobile"],
    token: json["token"],
    otp: json["otp"],
    address: json["address"],
    lat: json["lat"],
    lon: json["lon"],
    dateTime: DateTime.parse(json["date_time"]),
    countryCode: json["country_code"],
    country: json["country"],
    city: json["city"],
    image: json["image"],
    status: json["status"],
    goldWallet: json["gold_wallet"],
    amountWallet: json["amount_wallet"],
    referralCode: json["referral_code"],
    otherReferralCode: json["other_referral_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_name": userName,
    "email": email,
    "password": password,
    "mobile": mobile,
    "token": token,
    "otp": otp,
    "address": address,
    "lat": lat,
    "lon": lon,
    "date_time": dateTime.toIso8601String(),
    "country_code": countryCode,
    "country": country,
    "city": city,
    "image": image,
    "status": status,
    "gold_wallet": goldWallet,
    "amount_wallet": amountWallet,
    "referral_code": referralCode,
    "other_referral_code": otherReferralCode,
  };
}
