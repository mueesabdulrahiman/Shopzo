class CustomerDetailsModel {
  int? id;
  String? firstName;
  String? lastName;
  Shipping? shipping;
  Billing? billing;

  CustomerDetailsModel(
      {this.id, this.firstName, this.lastName, this.shipping, this.billing});

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsModel(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        shipping: json['shipping'] != null
            ? Shipping.fromJson(json['shipping'])
            : null,
        billing:
            json['billing'] != null ? Billing.fromJson(json['billing']) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'shipping': shipping?.toJson(),
      'billing': billing?.toJson()
    };
  }
}

class Shipping {
  String? company;
  String? address;
  String? postCode;
  String? city;
  String? phone;

  Shipping({this.company, this.address, this.city, this.postCode, this.phone});

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      company: json['company'],
      address: json['address_1'],
      city: json['city'],
      postCode: json['postcode'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'address_1': address,
      'city': city,
      'postcode': postCode,
    };
  }
}

class Billing {
  String? phone;
  Billing({this.phone});
  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(phone: json['phone']);
  }

  Map<String, dynamic> toJson() {
    return {'phone': phone};
  }
}
