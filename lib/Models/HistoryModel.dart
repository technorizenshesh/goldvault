class HistoryModel {
  String status;
  String message;
  List<HistoryResult> result;

  HistoryModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    status: json["status"],
    message: json["message"],
    result: List<HistoryResult>.from(json["result"].map((x) => HistoryResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class HistoryResult {
  String id;
  String userId;
  String amount;
  DateTime dateTime;
  String type;
  String image;

  HistoryResult({
    required this.id,
    required this.userId,
    required this.amount,
    required this.dateTime,
    required this.type,
    required this.image,
  });

  factory HistoryResult.fromJson(Map<String, dynamic> json) => HistoryResult(
    id: json["id"],
    userId: json["user_id"],
    amount: json["amount"],
    dateTime: DateTime.parse(json["date_time"]),
    type: json["type"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "amount": amount,
    "date_time": dateTime.toIso8601String(),
    "type": type,
    "image": image,
  };
}
