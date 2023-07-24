class AddCardModel {
  String status;
  String message;
  AddCardResult result;

  AddCardModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory AddCardModel.fromJson(Map<String, dynamic> json) => AddCardModel(
    status: json["status"],
    message: json["message"],
    result: AddCardResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result.toJson(),
  };
}

class AddCardResult {
  String id;
  String cardNumber;
  String year;
  String cvc;
  String cardHolderName;
  String remember;
  String userId;

  AddCardResult({
    required this.id,
    required this.cardNumber,
    required this.year,
    required this.cvc,
    required this.cardHolderName,
    required this.remember,
    required this.userId,
  });

  factory AddCardResult.fromJson(Map<String, dynamic> json) => AddCardResult(
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
