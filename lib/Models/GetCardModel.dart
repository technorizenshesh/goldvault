class GetCardModel {
  String status;
  String message;
  List<GetCardResult> result;

  GetCardModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory GetCardModel.fromJson(Map<String, dynamic> json) => GetCardModel(
    status: json["status"],
    message: json["message"],
    result: List<GetCardResult>.from(json["result"].map((x) => GetCardResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class GetCardResult {
  String id;
  String cardNumber;
  String year;
  String cvc;
  String cardHolderName;
  String remember;
  String userId;

  GetCardResult({
    required this.id,
    required this.cardNumber,
    required this.year,
    required this.cvc,
    required this.cardHolderName,
    required this.remember,
    required this.userId,
  });

  factory GetCardResult.fromJson(Map<String, dynamic> json) => GetCardResult(
    id: json["id"],
    cardNumber: json["card_number"],
    year: json["year"],
    cvc: json["cvc"],
    cardHolderName: json["card_holder_name"],
    remember: json["remember"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "card_number": cardNumber,
    "year": year,
    "cvc": cvc,
    "card_holder_name": cardHolderName,
    "remember": remember,
    "user_id": userId,
  };
}
