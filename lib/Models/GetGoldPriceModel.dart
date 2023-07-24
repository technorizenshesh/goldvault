class GetGoldPriceModel {
  String status;
  String message;
  GetGoldPriceResult result;

  GetGoldPriceModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory GetGoldPriceModel.fromJson(Map<String, dynamic> json) => GetGoldPriceModel(
    status: json["status"],
    message: json["message"],
    result: GetGoldPriceResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result.toJson(),
  };
}

class GetGoldPriceResult {
  DateTime date;
  int timestamp;
  String metal;
  String exchange;
  String currency;
  double price;
  double prevClosePrice;
  double ch;
  double chp;
  double priceGram24K;
  double priceGram22K;
  double priceGram21K;
  double priceGram20K;
  double priceGram18K;

  GetGoldPriceResult({
    required this.date,
    required this.timestamp,
    required this.metal,
    required this.exchange,
    required this.currency,
    required this.price,
    required this.prevClosePrice,
    required this.ch,
    required this.chp,
    required this.priceGram24K,
    required this.priceGram22K,
    required this.priceGram21K,
    required this.priceGram20K,
    required this.priceGram18K,
  });

  factory GetGoldPriceResult.fromJson(Map<String, dynamic> json) => GetGoldPriceResult(
    date: DateTime.parse(json["date"]),
    timestamp: json["timestamp"],
    metal: json["metal"],
    exchange: json["exchange"],
    currency: json["currency"],
    price: json["price"]?.toDouble(),
    prevClosePrice: json["prev_close_price"]?.toDouble(),
    ch: json["ch"]?.toDouble(),
    chp: json["chp"]?.toDouble(),
    priceGram24K: json["price_gram_24k"]?.toDouble(),
    priceGram22K: json["price_gram_22k"]?.toDouble(),
    priceGram21K: json["price_gram_21k"]?.toDouble(),
    priceGram20K: json["price_gram_20k"]?.toDouble(),
    priceGram18K: json["price_gram_18k"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "timestamp": timestamp,
    "metal": metal,
    "exchange": exchange,
    "currency": currency,
    "price": price,
    "prev_close_price": prevClosePrice,
    "ch": ch,
    "chp": chp,
    "price_gram_24k": priceGram24K,
    "price_gram_22k": priceGram22K,
    "price_gram_21k": priceGram21K,
    "price_gram_20k": priceGram20K,
    "price_gram_18k": priceGram18K,
  };
}
