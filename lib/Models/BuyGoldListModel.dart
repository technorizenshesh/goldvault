class BuyGoldListModel {
  String status;
  String message;
  List<BuyGoldListModelResult> result;

  BuyGoldListModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory BuyGoldListModel.fromJson(Map<String, dynamic> json) => BuyGoldListModel(
    status: json["status"],
    message: json["message"],
    result: List<BuyGoldListModelResult>.from(json["result"].map((x) => BuyGoldListModelResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class BuyGoldListModelResult {
  String id;
  String userId;
  String amount;
  String paymentMethod;
  String goldId;
  String currency;
  String goldSell;
  DateTime dateTime;
  String type;
  String otp;
  String step;
  String frontImage;
  String backImage;

  BuyGoldListModelResult({
    required this.id,
    required this.userId,
    required this.amount,
    required this.paymentMethod,
    required this.goldId,
    required this.currency,
    required this.goldSell,
    required this.dateTime,
    required this.type,
    required this.otp,
    required this.step,
    required this.frontImage,
    required this.backImage,
  });

  factory BuyGoldListModelResult.fromJson(Map<String, dynamic> json) => BuyGoldListModelResult(
    id: json["id"],
    userId: json["user_id"],
    amount: json["amount"],
    paymentMethod: json["payment_method"],
    goldId: json["gold_id"],
    currency: json["currency"],
    goldSell: json["gold_sell"],
    dateTime: DateTime.parse(json["date_time"]),
    type: json["type"],
    otp: json["otp"],
    step: json["step"],
    frontImage: json["front_image"],
    backImage: json["back_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "amount": amount,
    "payment_method": paymentMethod,
    "gold_id": goldId,
    "currency": currency,
    "gold_sell": goldSell,
    "date_time": dateTime.toIso8601String(),
    "type": type,
    "otp": otp,
    "step": step,
    "front_image": frontImage,
    "back_image": backImage,
  };
}
