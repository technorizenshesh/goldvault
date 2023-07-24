 class AboutUsModel {
  String status;
  String message;
  AboutUsResult result;

  AboutUsModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
    status: json["status"],
    message: json["message"],
    result: AboutUsResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result.toJson(),
  };
}

class AboutUsResult {
  String id;
  String content;
  DateTime dateTime;
  String image;


  AboutUsResult({
    required this.id,
    required this.content,
    required this.dateTime,
    required this.image,

  });

  factory AboutUsResult.fromJson(Map<String, dynamic> json) => AboutUsResult(
    id: json["id"],
    content: json["content"],
    dateTime: DateTime.parse(json["date_time"]),
    image: json["image"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "date_time": dateTime.toIso8601String(),
    "image": image,
  };
}
