class RequestSellModel {
  String status;
  String message;
  RequestSellResult result;

  RequestSellModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory RequestSellModel.fromJson(Map<String, dynamic> json) => RequestSellModel(
    status: json["status"],
    message: json["message"],
    result: RequestSellResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result.toJson(),
  };
}

class RequestSellResult {
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

  RequestSellResult({
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
  });

  factory RequestSellResult.fromJson(Map<String, dynamic> json) => RequestSellResult(
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
  };
}
