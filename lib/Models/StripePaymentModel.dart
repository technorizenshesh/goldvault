class StripePaymentModel {
  String status;
  String message;
  StripePaymentResult result;

  StripePaymentModel({
    required this.status,
    required this.message,
    required this.result,
  });

  factory StripePaymentModel.fromJson(Map<String, dynamic> json) => StripePaymentModel(
    status: json["status"],
    message: json["message"],
    result: StripePaymentResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result.toJson(),
  };
}

class StripePaymentResult {
  String id;
  String object;
  int amount;
  int amountCaptured;
  int amountRefunded;
  dynamic application;
  dynamic applicationFee;
  dynamic applicationFeeAmount;
  String balanceTransaction;
  BillingDetails billingDetails;
  String calculatedStatementDescriptor;
  bool captured;
  int created;
  String currency;
  dynamic customer;
  dynamic description;
  dynamic destination;
  dynamic dispute;
  bool disputed;
  dynamic failureBalanceTransaction;
  dynamic failureCode;
  dynamic failureMessage;
  FraudDetails fraudDetails;
  dynamic invoice;
  bool livemode;
  Metadata metadata;
  dynamic onBehalfOf;
  dynamic order;
  Outcome outcome;
  bool paid;
  dynamic paymentIntent;
  String paymentMethod;
  PaymentMethodDetails paymentMethodDetails;
  dynamic receiptEmail;
  dynamic receiptNumber;
  String receiptUrl;
  bool refunded;
  Refunds refunds;
  dynamic review;
  dynamic shipping;
  Source source;
  dynamic sourceTransfer;
  dynamic statementDescriptor;
  dynamic statementDescriptorSuffix;
  String status;
  dynamic transferData;
  dynamic transferGroup;

  StripePaymentResult({
    required this.id,
    required this.object,
    required this.amount,
    required this.amountCaptured,
    required this.amountRefunded,
    this.application,
    this.applicationFee,
    this.applicationFeeAmount,
    required this.balanceTransaction,
    required this.billingDetails,
    required this.calculatedStatementDescriptor,
    required this.captured,
    required this.created,
    required this.currency,
    this.customer,
    this.description,
    this.destination,
    this.dispute,
    required this.disputed,
    this.failureBalanceTransaction,
    this.failureCode,
    this.failureMessage,
    required this.fraudDetails,
    this.invoice,
    required this.livemode,
    required this.metadata,
    this.onBehalfOf,
    this.order,
    required this.outcome,
    required this.paid,
    this.paymentIntent,
    required this.paymentMethod,
    required this.paymentMethodDetails,
    this.receiptEmail,
    this.receiptNumber,
    required this.receiptUrl,
    required this.refunded,
    required this.refunds,
    this.review,
    this.shipping,
    required this.source,
    this.sourceTransfer,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    required this.status,
    this.transferData,
    this.transferGroup,
  });

  factory StripePaymentResult.fromJson(Map<String, dynamic> json) => StripePaymentResult(
    id: json["id"],
    object: json["object"],
    amount: json["amount"],
    amountCaptured: json["amount_captured"],
    amountRefunded: json["amount_refunded"],
    application: json["application"],
    applicationFee: json["application_fee"],
    applicationFeeAmount: json["application_fee_amount"],
    balanceTransaction: json["balance_transaction"],
    billingDetails: BillingDetails.fromJson(json["billing_details"]),
    calculatedStatementDescriptor: json["calculated_statement_descriptor"],
    captured: json["captured"],
    created: json["created"],
    currency: json["currency"],
    customer: json["customer"],
    description: json["description"],
    destination: json["destination"],
    dispute: json["dispute"],
    disputed: json["disputed"],
    failureBalanceTransaction: json["failure_balance_transaction"],
    failureCode: json["failure_code"],
    failureMessage: json["failure_message"],
    fraudDetails: FraudDetails.fromJson(json["fraud_details"]),
    invoice: json["invoice"],
    livemode: json["livemode"],
    metadata: Metadata.fromJson(json["metadata"]),
    onBehalfOf: json["on_behalf_of"],
    order: json["order"],
    outcome: Outcome.fromJson(json["outcome"]),
    paid: json["paid"],
    paymentIntent: json["payment_intent"],
    paymentMethod: json["payment_method"],
    paymentMethodDetails: PaymentMethodDetails.fromJson(json["payment_method_details"]),
    receiptEmail: json["receipt_email"],
    receiptNumber: json["receipt_number"],
    receiptUrl: json["receipt_url"],
    refunded: json["refunded"],
    refunds: Refunds.fromJson(json["refunds"]),
    review: json["review"],
    shipping: json["shipping"],
    source: Source.fromJson(json["source"]),
    sourceTransfer: json["source_transfer"],
    statementDescriptor: json["statement_descriptor"],
    statementDescriptorSuffix: json["statement_descriptor_suffix"],
    status: json["status"],
    transferData: json["transfer_data"],
    transferGroup: json["transfer_group"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "amount": amount,
    "amount_captured": amountCaptured,
    "amount_refunded": amountRefunded,
    "application": application,
    "application_fee": applicationFee,
    "application_fee_amount": applicationFeeAmount,
    "balance_transaction": balanceTransaction,
    "billing_details": billingDetails.toJson(),
    "calculated_statement_descriptor": calculatedStatementDescriptor,
    "captured": captured,
    "created": created,
    "currency": currency,
    "customer": customer,
    "description": description,
    "destination": destination,
    "dispute": dispute,
    "disputed": disputed,
    "failure_balance_transaction": failureBalanceTransaction,
    "failure_code": failureCode,
    "failure_message": failureMessage,
    "fraud_details": fraudDetails.toJson(),
    "invoice": invoice,
    "livemode": livemode,
    "metadata": metadata.toJson(),
    "on_behalf_of": onBehalfOf,
    "order": order,
    "outcome": outcome.toJson(),
    "paid": paid,
    "payment_intent": paymentIntent,
    "payment_method": paymentMethod,
    "payment_method_details": paymentMethodDetails.toJson(),
    "receipt_email": receiptEmail,
    "receipt_number": receiptNumber,
    "receipt_url": receiptUrl,
    "refunded": refunded,
    "refunds": refunds.toJson(),
    "review": review,
    "shipping": shipping,
    "source": source.toJson(),
    "source_transfer": sourceTransfer,
    "statement_descriptor": statementDescriptor,
    "statement_descriptor_suffix": statementDescriptorSuffix,
    "status": status,
    "transfer_data": transferData,
    "transfer_group": transferGroup,
  };
}

class BillingDetails {
  Address address;
  dynamic email;
  dynamic name;
  dynamic phone;

  BillingDetails({
    required this.address,
    this.email,
    this.name,
    this.phone,
  });

  factory BillingDetails.fromJson(Map<String, dynamic> json) => BillingDetails(
    address: Address.fromJson(json["address"]),
    email: json["email"],
    name: json["name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "address": address.toJson(),
    "email": email,
    "name": name,
    "phone": phone,
  };
}

class Address {
  dynamic city;
  dynamic country;
  dynamic line1;
  dynamic line2;
  dynamic postalCode;
  dynamic state;

  Address({
    this.city,
    this.country,
    this.line1,
    this.line2,
    this.postalCode,
    this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    city: json["city"],
    country: json["country"],
    line1: json["line1"],
    line2: json["line2"],
    postalCode: json["postal_code"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "country": country,
    "line1": line1,
    "line2": line2,
    "postal_code": postalCode,
    "state": state,
  };
}

class FraudDetails {
  FraudDetails();

  factory FraudDetails.fromJson(Map<String, dynamic> json) => FraudDetails(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Metadata {
  String userId;

  Metadata({
    required this.userId,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };
}

class Outcome {
  String networkStatus;
  dynamic reason;
  String riskLevel;
  int riskScore;
  String sellerMessage;
  String type;

  Outcome({
    required this.networkStatus,
    this.reason,
    required this.riskLevel,
    required this.riskScore,
    required this.sellerMessage,
    required this.type,
  });

  factory Outcome.fromJson(Map<String, dynamic> json) => Outcome(
    networkStatus: json["network_status"],
    reason: json["reason"],
    riskLevel: json["risk_level"],
    riskScore: json["risk_score"],
    sellerMessage: json["seller_message"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "network_status": networkStatus,
    "reason": reason,
    "risk_level": riskLevel,
    "risk_score": riskScore,
    "seller_message": sellerMessage,
    "type": type,
  };
}

class PaymentMethodDetails {
  Card card;
  String type;

  PaymentMethodDetails({
    required this.card,
    required this.type,
  });

  factory PaymentMethodDetails.fromJson(Map<String, dynamic> json) => PaymentMethodDetails(
    card: Card.fromJson(json["card"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "card": card.toJson(),
    "type": type,
  };
}

class Card {
  String brand;
  Checks checks;
  String country;
  int expMonth;
  int expYear;
  String fingerprint;
  String funding;
  dynamic installments;
  String last4;
  dynamic mandate;
  String network;
  NetworkToken networkToken;
  dynamic threeDSecure;
  dynamic wallet;

  Card({
    required this.brand,
    required this.checks,
    required this.country,
    required this.expMonth,
    required this.expYear,
    required this.fingerprint,
    required this.funding,
    this.installments,
    required this.last4,
    this.mandate,
    required this.network,
    required this.networkToken,
    this.threeDSecure,
    this.wallet,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    brand: json["brand"],
    checks: Checks.fromJson(json["checks"]),
    country: json["country"],
    expMonth: json["exp_month"],
    expYear: json["exp_year"],
    fingerprint: json["fingerprint"],
    funding: json["funding"],
    installments: json["installments"],
    last4: json["last4"],
    mandate: json["mandate"],
    network: json["network"],
    networkToken: NetworkToken.fromJson(json["network_token"]),
    threeDSecure: json["three_d_secure"],
    wallet: json["wallet"],
  );

  Map<String, dynamic> toJson() => {
    "brand": brand,
    "checks": checks.toJson(),
    "country": country,
    "exp_month": expMonth,
    "exp_year": expYear,
    "fingerprint": fingerprint,
    "funding": funding,
    "installments": installments,
    "last4": last4,
    "mandate": mandate,
    "network": network,
    "network_token": networkToken.toJson(),
    "three_d_secure": threeDSecure,
    "wallet": wallet,
  };
}

class Checks {
  dynamic addressLine1Check;
  dynamic addressPostalCodeCheck;
  String cvcCheck;

  Checks({
    this.addressLine1Check,
    this.addressPostalCodeCheck,
    required this.cvcCheck,
  });

  factory Checks.fromJson(Map<String, dynamic> json) => Checks(
    addressLine1Check: json["address_line1_check"],
    addressPostalCodeCheck: json["address_postal_code_check"],
    cvcCheck: json["cvc_check"],
  );

  Map<String, dynamic> toJson() => {
    "address_line1_check": addressLine1Check,
    "address_postal_code_check": addressPostalCodeCheck,
    "cvc_check": cvcCheck,
  };
}

class NetworkToken {
  bool used;

  NetworkToken({
    required this.used,
  });

  factory NetworkToken.fromJson(Map<String, dynamic> json) => NetworkToken(
    used: json["used"],
  );

  Map<String, dynamic> toJson() => {
    "used": used,
  };
}

class Refunds {
  String object;
  List<dynamic> data;
  bool hasMore;
  int totalCount;
  String url;

  Refunds({
    required this.object,
    required this.data,
    required this.hasMore,
    required this.totalCount,
    required this.url,
  });

  factory Refunds.fromJson(Map<String, dynamic> json) => Refunds(
    object: json["object"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
    hasMore: json["has_more"],
    totalCount: json["total_count"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "object": object,
    "data": List<dynamic>.from(data.map((x) => x)),
    "has_more": hasMore,
    "total_count": totalCount,
    "url": url,
  };
}

class Source {
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
  dynamic customer;
  String cvcCheck;
  dynamic dynamicLast4;
  int expMonth;
  int expYear;
  String fingerprint;
  String funding;
  String last4;
  FraudDetails metadata;
  dynamic name;
  dynamic tokenizationMethod;
  dynamic wallet;

  Source({
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
    this.customer,
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

  factory Source.fromJson(Map<String, dynamic> json) => Source(
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
    customer: json["customer"],
    cvcCheck: json["cvc_check"],
    dynamicLast4: json["dynamic_last4"],
    expMonth: json["exp_month"],
    expYear: json["exp_year"],
    fingerprint: json["fingerprint"],
    funding: json["funding"],
    last4: json["last4"],
    metadata: FraudDetails.fromJson(json["metadata"]),
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
    "customer": customer,
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
