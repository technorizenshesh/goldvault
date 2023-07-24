class GeneralModel {
  String status;
  String message;
  String result;

  GeneralModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory GeneralModel.fromJson(Map<String, dynamic> json) => GeneralModel(
    status: json["status"],
    message: json["message"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result,
  };
}
