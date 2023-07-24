class UserVerificationModel {
  String status;
  String message;
  UserVerificationResult result;

  UserVerificationModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory UserVerificationModel.fromJson(Map<String, dynamic> json) => UserVerificationModel(
    status: json["status"],
    message: json["message"],
    result: UserVerificationResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result.toJson(),
  };
}

class UserVerificationResult {
  String id;
  String userId;
  String firstName;
  String lastName;
  String address;
  String bankNumber;
  String frontImage;
  String backImage;
  String bankStatement;
  DateTime dateTime;
  String country;
  String city;
  String zipcode;

  UserVerificationResult({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.bankNumber,
    required this.frontImage,
    required this.backImage,
    required this.bankStatement,
    required this.dateTime,
    required this.country,
    required this.city,
    required this.zipcode,
  });

  factory UserVerificationResult.fromJson(Map<String, dynamic> json) => UserVerificationResult(
    id: json["id"],
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    address: json["address"],
    bankNumber: json["bank_number"],
    frontImage: json["front_image"],
    backImage: json["back_image"],
    bankStatement: json["bank_statement"],
    dateTime: DateTime.parse(json["date_time"]),
    country: json["country"],
    city: json["city"],
    zipcode: json["zipcode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "address": address,
    "bank_number": bankNumber,
    "front_image": frontImage,
    "back_image": backImage,
    "bank_statement": bankStatement,
    "date_time": dateTime.toIso8601String(),
    "country": country,
    "city": city,
    "zipcode": zipcode,
  };
}
