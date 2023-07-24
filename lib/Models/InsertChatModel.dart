class InsertChatModel {
  String status;
  String message;
  InsertChatResult result;

  InsertChatModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory InsertChatModel.fromJson(Map<String, dynamic> json) => InsertChatModel(
    status: json["status"],
    message: json["message"],
    result: InsertChatResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result.toJson(),
  };
}

class InsertChatResult {
  String id;
  String senderId;
  String receiverId;
  String chatMessage;
  String chatImage;
  String chatAudio;
  String chatVideo;
  String chatDocument;
  String lat;
  String lon;
  String name;
  String contact;
  String clearChat;
  String status;
  DateTime date;

  InsertChatResult({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.chatMessage,
    required this.chatImage,
    required this.chatAudio,
    required this.chatVideo,
    required this.chatDocument,
    required this.lat,
    required this.lon,
    required this.name,
    required this.contact,
    required this.clearChat,
    required this.status,
    required this.date,
  });

  factory InsertChatResult.fromJson(Map<String, dynamic> json) => InsertChatResult(
    id: json["id"],
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    chatMessage: json["chat_message"],
    chatImage: json["chat_image"],
    chatAudio: json["chat_audio"],
    chatVideo: json["chat_video"],
    chatDocument: json["chat_document"],
    lat: json["lat"],
    lon: json["lon"],
    name: json["name"],
    contact: json["contact"],
    clearChat: json["clear_chat"],
    status: json["status"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "chat_message": chatMessage,
    "chat_image": chatImage,
    "chat_audio": chatAudio,
    "chat_video": chatVideo,
    "chat_document": chatDocument,
    "lat": lat,
    "lon": lon,
    "name": name,
    "contact": contact,
    "clear_chat": clearChat,
    "status": status,
    "date": date.toIso8601String(),
  };
}
