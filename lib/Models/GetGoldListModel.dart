class GetGoldListModel {
  String status;
  String message;
  List<GetGoldListResult> result;

  GetGoldListModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory GetGoldListModel.fromJson(Map<String, dynamic> json) => GetGoldListModel(
    status: json["status"],
    message: json["message"],
    result: List<GetGoldListResult>.from(json["result"].map((x) => GetGoldListResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class GetGoldListResult {
  String id;
  String goldName;
  String brand;
  String purity;
  String weight;
  String size;
  String frontImage;
  String backImage;
  DateTime dateTime;
  String status;

  GetGoldListResult({
    required this.id,
    required this.goldName,
    required this.brand,
    required this.purity,
    required this.weight,
    required this.size,
    required this.frontImage,
    required this.backImage,
    required this.dateTime,
    required this.status,
  });

  factory GetGoldListResult.fromJson(Map<String, dynamic> json) => GetGoldListResult(
    id: json["id"],
    goldName: json["gold_name"],
    brand: json["brand"],
    purity: json["purity"],
    weight: json["weight"],
    size: json["size"],
    frontImage: json["front_image"],
    backImage: json["back_image"],
    dateTime: DateTime.parse(json["date_time"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "gold_name": goldName,
    "brand": brand,
    "purity": purity,
    "weight": weight,
    "size": size,
    "front_image": frontImage,
    "back_image": backImage,
    "date_time": dateTime.toIso8601String(),
    "status": status,
  };
}
