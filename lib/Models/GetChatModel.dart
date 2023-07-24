class GetChatModel {
  String status;
  String message;
  List<GetChatResult> result;

  GetChatModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory GetChatModel.fromJson(Map<String, dynamic> json) => GetChatModel(
    status: json["status"],
    message: json["message"],
    result: List<GetChatResult>.from(json["result"].map((x) => GetChatResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class GetChatResult {
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
  String result;
  ErDetail senderDetail;
  ErDetail receiverDetail;

  GetChatResult({
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
    required this.result,
    required this.senderDetail,
    required this.receiverDetail,
  });

  factory GetChatResult.fromJson(Map<String, dynamic> json) => GetChatResult(
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
    result: json["result"],
    senderDetail: ErDetail.fromJson(json["sender_detail"]),
    receiverDetail: ErDetail.fromJson(json["receiver_detail"]),
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
    "result": result,
    "sender_detail": senderDetail.toJson(),
    "receiver_detail": receiverDetail.toJson(),
  };
}

class ErDetail {
  String id;
  String userName;
  String email;
  String password;
  String mobile;
  String token;
  String otp;
  String address;
  String lat;
  String lon;
  DateTime dateTime;
  String countryCode;
  String country;
  String city;
  String image;
  String status;
  String goldWallet;
  String amountWallet;
  String? receiverImage;
  String? senderImage;

  ErDetail({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.mobile,
    required this.token,
    required this.otp,
    required this.address,
    required this.lat,
    required this.lon,
    required this.dateTime,
    required this.countryCode,
    required this.country,
    required this.city,
    required this.image,
    required this.status,
    required this.goldWallet,
    required this.amountWallet,
    this.receiverImage,
    this.senderImage,
  });

  factory ErDetail.fromJson(Map<String, dynamic> json) => ErDetail(
    id: json["id"],
    userName: json["user_name"],
    email: json["email"],
    password: json["password"],
    mobile: json["mobile"],
    token: json["token"],
    otp: json["otp"],
    address: json["address"],
    lat: json["lat"],
    lon: json["lon"],
    dateTime: DateTime.parse(json["date_time"]),
    countryCode: json["country_code"],
    country: json["country"],
    city: json["city"],
    image: json["image"],
    status: json["status"],
    goldWallet: json["gold_wallet"],
    amountWallet: json["amount_wallet"],
    receiverImage: json["receiver_image"],
    senderImage: json["sender_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_name": userName,
    "email": email,
    "password": password,
    "mobile": mobile,
    "token": token,
    "otp": otp,
    "address": address,
    "lat": lat,
    "lon": lon,
    "date_time": dateTime.toIso8601String(),
    "country_code": countryCode,
    "country": country,
    "city": city,
    "image": image,
    "status": status,
    "gold_wallet": goldWallet,
    "amount_wallet": amountWallet,
    "receiver_image": receiverImage,
    "sender_image": senderImage,
  };
}
