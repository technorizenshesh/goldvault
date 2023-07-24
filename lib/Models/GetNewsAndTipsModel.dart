class GetNewsAndTipsModel {
  String status;
  String message;
  List<GetNewsAndTipsResult> result;

  GetNewsAndTipsModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory GetNewsAndTipsModel.fromJson(Map<String, dynamic> json) => GetNewsAndTipsModel(
    status: json["status"],
    message: json["message"],
    result: List<GetNewsAndTipsResult>.from(json["result"].map((x) => GetNewsAndTipsResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class GetNewsAndTipsResult {
  String id;
  String title;
  String content;
  String image;
  DateTime dateTime;

  GetNewsAndTipsResult({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.dateTime,
  });

  factory GetNewsAndTipsResult.fromJson(Map<String, dynamic> json) => GetNewsAndTipsResult(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    image: json["image"],
    dateTime: DateTime.parse(json["date_time"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "image": image,
    "date_time": dateTime.toIso8601String(),
  };
}
