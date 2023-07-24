class SellGoldFractionModel {
  String status;
  String message;
  List<SellGoldFractionResult> result;

  SellGoldFractionModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory SellGoldFractionModel.fromJson(Map<String, dynamic> json) => SellGoldFractionModel(
    status: json["status"],
    message: json["message"],
    result: List<SellGoldFractionResult>.from(json["result"].map((x) => SellGoldFractionResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class SellGoldFractionResult {
  String id;
  String name;
  DateTime dateTime;
  String percentage;

  SellGoldFractionResult({
    required this.id,
    required this.name,
    required this.dateTime,
    required this.percentage,

  });

  factory SellGoldFractionResult.fromJson(Map<String, dynamic> json) => SellGoldFractionResult(
    id: json["id"],
    name: json["name"],
    dateTime: DateTime.parse(json["date_time"]),
    percentage: json["percentage"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "date_time": dateTime.toIso8601String(),
    "percentage": percentage,
  };
}
