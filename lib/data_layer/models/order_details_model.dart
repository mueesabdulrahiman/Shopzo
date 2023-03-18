class OrderDetailsModel {
  int? orderId;
  String? orderNumber;
  String? paymentMethod;
  String? orderStatus;
  DateTime? orderDate;
  Shipping? shipping;
  List<LineItems>? lineItems;
  double? totalAmount;
  double? shippingTotal;
  double? itemTotalAmount;

  OrderDetailsModel({
    this.orderId,
    this.orderNumber,
    this.paymentMethod,
    this.orderStatus,
    this.orderDate,
    this.shipping,
    this.lineItems,
    this.totalAmount,
    this.shippingTotal,
    this.itemTotalAmount,
  });

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    orderId = json['id'];
    orderNumber = json['number'];
    paymentMethod = json['payment_method'];
    orderStatus = json['status'];
    orderDate = DateTime.parse(json['date_created']);
    shipping =
        json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null;

    //  if (json["line_items"] != []) {
    lineItems = [];
    lineItems =
        (json['line_items'] as List).map((e) => LineItems.fromJson(e)).toList();

    // json['line_items'].forEach((e) {
    //   lineItems?.add(LineItems.fromJson(e));
    // });

    itemTotalAmount = lineItems!.isNotEmpty
        ? lineItems?.map<double>((e) => e.totalCost!).reduce((a, b) => a + b)
        : 0;      
    // }

    totalAmount = double.parse(json['total']);
    shippingTotal = double.parse(json['shipping_total']);

    // lineItems= json['line_items'] != null ? json['line_items'].map((e) {

    //   return lineItems!.add(LineItems.fromJson(e));
    // } ).toList();
  }
}

class LineItems {
  int? productId;
  String? productName;
  double? totalCost;
  int? quantity;

  LineItems({this.productId, this.totalCost, this.quantity, this.productName});

  factory LineItems.fromJson(Map<String, dynamic> json) {
    return LineItems(
        productId: json['product_id'],
        quantity: json['quantity'],
        productName: json['name'],
        totalCost: double.parse(json['total']));
  }
}

class Shipping {
  String? company;
  String? address1;
  String? address2;

  String? city;
  // String? phone;

  Shipping({
    this.company,
    this.address1,
    this.address2,
    this.city,
    // this.postCode,
    // this.phone
  });

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      company: json['company'],
      address1: json['address_1'],
      address2: json['address_2'],
      city: json['city'],
      // postCode: json['postcode'],
      // phone: json['phone'],
    );
  }
}
