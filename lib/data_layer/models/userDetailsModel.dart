class CustomerDetailsModel {
  int? id;
  String? firstName;
  String? lastName;
  Shipping? shipping;

  CustomerDetailsModel({this.firstName, this.id, this.lastName, this.shipping});

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      shipping:
          json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null,
    );
  }
}

class Shipping {
  String? company;
  String? address;
  // String? postCode;
  String? city;
  // String? phone;

  Shipping({
    this.company,
    this.address,
    this.city,
    // this.postCode,
    // this.phone
  });

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
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
