class OrderModel {
  int? customerId;
  int? orderId;
  String? orderNumber;
  String? status;
  DateTime? orderDate;
  Shipping1? shipping;
  Billing? billing;
  List<LineItems>? lineItems;
  String? paymentMethod;

  OrderModel(
      {this.customerId,
      this.orderId,
      this.orderNumber,
      this.status,
      this.orderDate,
      this.shipping ,
      this.lineItems,
      this.paymentMethod});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      customerId: json['customer_id'],
      orderId: json['id'],
      status: json['status'],
      orderNumber: json['order_key'],
      orderDate: DateTime.parse(json['date_created']),
      paymentMethod: json['payment_method'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['customer_id'] = customerId;
    map['shipping'] = shipping;
    map['line_items'] = lineItems?.map((e) => e.toJson()).toList() ?? [];
    map['status'] = status;
    map['payment_method'] = paymentMethod;
   // map['billing'] = billing;
    return map;
  }
}

class LineItems {
  int? productId;
  int? cost;
  int? quantity;
  LineItems({this.productId, this.cost, this.quantity});

  factory LineItems.fromJson(Map<String, dynamic> json) {
    return LineItems(
      productId: json['product_id'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
    };
  }
}

class Shipping1 {
  String? company;
  String? address;

  String? city;
  // String? phone;

  Shipping1({
    this.company,
    this.address,
    this.city,
    // this.postCode,
    // this.phone
  });

  factory Shipping1.fromJson(Map<String, dynamic> json) {
    return Shipping1(
      company: json['company'],
      address: json['address_1'],
      city: json['city'],
      // postCode: json['postcode'],
      // phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'address_1': address,
      'city': city,
      // 'postcode': postCode,
      // 'phone': phone,
    };
  }
}

class Billing {
  String? phone;
  Billing({this.phone});

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
    };
  }

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(phone: json['phone']);
  }
}
