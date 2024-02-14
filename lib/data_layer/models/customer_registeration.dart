class Customer {
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  Shipping? shipping;
  Billing? billing;

  Customer(this.email, this.password, this.firstName, this.lastName,
      this.shipping, this.billing);

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'username': "$firstName $lastName",
      'shipping': shipping?.toJson(),
      'billing': billing?.toJson(),
    };
  }
}

//shipping!.company!.isNotEmpty ? shipping?.toJson() : null
class Shipping {
  String? company;
  String? address;
  String? city;
  // int? postCode;
  Shipping({
    this.company,
    this.address,
    this.city,
    //this.postCode
  });

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'address_1': address,
      'city': city,
    };
  }
}

class Billing {
  String? company;
  String? address;
  String? city;
  String? phone;

  Billing({this.company, this.address, this.city, this.phone});

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'address_1': address,
      'city': city,
      'phone': phone,
    };
  }
}
