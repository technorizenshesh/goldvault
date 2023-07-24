class GetGoldByDate {
  String status;
  String message;
  List<GetGoldByDateResult> result;

  GetGoldByDate({
    required this.status,
    required this.message,
    required this.result,
  });

  factory GetGoldByDate.fromJson(Map<String, dynamic> json) => GetGoldByDate(
    status: json["status"],
    message: json["message"],
    result: List<GetGoldByDateResult>.from(json["result"].map((x) => GetGoldByDateResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class GetGoldByDateResult {
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
  double priceGram16K;
  double priceGram14K;
  double priceGram10K;

  GetGoldByDateResult({
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
    required this.priceGram16K,
    required this.priceGram14K,
    required this.priceGram10K,
  });

  factory GetGoldByDateResult.fromJson(Map<String, dynamic> json) => GetGoldByDateResult(
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
    priceGram16K: json["price_gram_16k"]?.toDouble(),
    priceGram14K: json["price_gram_14k"]?.toDouble(),
    priceGram10K: json["price_gram_10k"]?.toDouble(),
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
    "price_gram_16k": priceGram16K,
    "price_gram_14k": priceGram14K,
    "price_gram_10k": priceGram10K,
  };
}
