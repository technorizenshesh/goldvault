class GetPaymentTokenModel {
  String status;
  String message;
  GetPaymentTokenResult result;

  GetPaymentTokenModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory GetPaymentTokenModel.fromJson(Map<String, dynamic> json) => GetPaymentTokenModel(
    status: json["status"],
    message: json["message"],
    result: GetPaymentTokenResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result.toJson(),
  };
}

class GetPaymentTokenResult {
  String id;
  String object;
  Card card;
  String clientIp;
  int created;
  bool livemode;
  String type;
  bool used;

  GetPaymentTokenResult({
    required this.id,
    required this.object,
    required this.card,
    required this.clientIp,
    required this.created,
    required this.livemode,
    required this.type,
    required this.used,
  });

  factory GetPaymentTokenResult.fromJson(Map<String, dynamic> json) => GetPaymentTokenResult(
    id: json["id"],
    object: json["object"],
    card: Card.fromJson(json["card"]),
    clientIp: json["client_ip"],
    created: json["created"],
    livemode: json["livemode"],
    type: json["type"],
    used: json["used"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "card": card.toJson(),
    "client_ip": clientIp,
    "created": created,
    "livemode": livemode,
    "type": type,
    "used": used,
  };
}

class Card {
  String id;
  String object;
  dynamic addressCity;
  dynamic addressCountry;
  dynamic addressLine1;
  dynamic addressLine1Check;
  dynamic addressLine2;
  dynamic addressState;
  dynamic addressZip;
  dynamic addressZipCheck;
  String brand;
  String country;
  String cvcCheck;
  dynamic dynamicLast4;
  int expMonth;
  int expYear;
  String fingerprint;
  String funding;
  String last4;
  Metadata metadata;
  dynamic name;
  dynamic tokenizationMethod;
  dynamic wallet;

  Card({
    required this.id,
    required this.object,
    this.addressCity,
    this.addressCountry,
    this.addressLine1,
    this.addressLine1Check,
    this.addressLine2,
    this.addressState,
    this.addressZip,
    this.addressZipCheck,
    required this.brand,
    required this.country,
    required this.cvcCheck,
    this.dynamicLast4,
    required this.expMonth,
    required this.expYear,
    required this.fingerprint,
    required this.funding,
    required this.last4,
    required this.metadata,
    this.name,
    this.tokenizationMethod,
    this.wallet,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    id: json["id"],
    object: json["object"],
    addressCity: json["address_city"],
    addressCountry: json["address_country"],
    addressLine1: json["address_line1"],
    addressLine1Check: json["address_line1_check"],
    addressLine2: json["address_line2"],
    addressState: json["address_state"],
    addressZip: json["address_zip"],
    addressZipCheck: json["address_zip_check"],
    brand: json["brand"],
    country: json["country"],
    cvcCheck: json["cvc_check"],
    dynamicLast4: json["dynamic_last4"],
    expMonth: json["exp_month"],
    expYear: json["exp_year"],
    fingerprint: json["fingerprint"],
    funding: json["funding"],
    last4: json["last4"],
    metadata: Metadata.fromJson(json["metadata"]),
    name: json["name"],
    tokenizationMethod: json["tokenization_method"],
    wallet: json["wallet"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "address_city": addressCity,
    "address_country": addressCountry,
    "address_line1": addressLine1,
    "address_line1_check": addressLine1Check,
    "address_line2": addressLine2,
    "address_state": addressState,
    "address_zip": addressZip,
    "address_zip_check": addressZipCheck,
    "brand": brand,
    "country": country,
    "cvc_check": cvcCheck,
    "dynamic_last4": dynamicLast4,
    "exp_month": expMonth,
    "exp_year": expYear,
    "fingerprint": fingerprint,
    "funding": funding,
    "last4": last4,
    "metadata": metadata.toJson(),
    "name": name,
    "tokenization_method": tokenizationMethod,
    "wallet": wallet,
  };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
  );

  Map<String, dynamic> toJson() => {
  };
}
