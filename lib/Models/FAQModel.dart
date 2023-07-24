class FAQModel {
  String status;
  String message;
  List<FAQResult> result;

  FAQModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory FAQModel.fromJson(Map<String, dynamic> json) => FAQModel(
    status: json["status"],
    message: json["message"],
    result: List<FAQResult>.from(json["result"].map((x) => FAQResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class FAQResult {
  String id;
  String question;
  String answer;
  DateTime dateTime;

  FAQResult({
    required this.id,
    required this.question,
    required this.answer,
    required this.dateTime,
  });

  factory FAQResult.fromJson(Map<String, dynamic> json) => FAQResult(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
    dateTime: DateTime.parse(json["date_time"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
    "date_time": dateTime.toIso8601String(),
  };
}
