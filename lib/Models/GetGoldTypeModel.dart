class GetGoldTypeModel {
  String status;
  String message;
  List<GetGoldTypeResult> result;

  GetGoldTypeModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory GetGoldTypeModel.fromJson(Map<String, dynamic> json) => GetGoldTypeModel(
    status: json["status"],
    message: json["message"],
    result: List<GetGoldTypeResult>.from(json["result"].map((x) => GetGoldTypeResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class GetGoldTypeResult {
  String id;
  String goldId;
  String goldPrice;
  String goldInGram;
  DateTime dateTime;

  GetGoldTypeResult({
    required this.id,
    required this.goldId,
    required this.goldPrice,
    required this.goldInGram,
    required this.dateTime,
  });

  factory GetGoldTypeResult.fromJson(Map<String, dynamic> json) => GetGoldTypeResult(
    id: json["id"],
    goldId: json["gold_id"],
    goldPrice: json["gold_price"],
    goldInGram: json["gold_in_gram"],
    dateTime: DateTime.parse(json["date_time"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "gold_id": goldId,
    "gold_price": goldPrice,
    "gold_in_gram": goldInGram,
    "date_time": dateTime.toIso8601String(),
  };
}
