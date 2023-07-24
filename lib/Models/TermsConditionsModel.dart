class TermsConditionModel {
  String status;
  String message;
  TermsConditionResult result;

  TermsConditionModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory TermsConditionModel.fromJson(Map<String, dynamic> json) => TermsConditionModel(
    status: json["status"],
    message: json["message"],
    result: TermsConditionResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result.toJson(),
  };
}

class TermsConditionResult {
  String id;
  String content;
  DateTime dateTime;

  TermsConditionResult({
    required this.id,
    required this.content,
    required this.dateTime,
  });

  factory TermsConditionResult.fromJson(Map<String, dynamic> json) => TermsConditionResult(
    id: json["id"],
    content: json["content"],
    dateTime: DateTime.parse(json["date_time"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "date_time": dateTime.toIso8601String(),
  };
}
