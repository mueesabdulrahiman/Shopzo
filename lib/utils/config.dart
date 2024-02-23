class Config {
  //static String key = 'ck_21a1cfac07deb405f10313a2438da128635f8d80';
  static String key = 'ck_ea854bbf2412b3eb4207a9d6bd168dda35cb70b1';
  //static String secret = 'cs_868a244eae73cfaebf5beeaefeba2fd0d18074b6';
  static String secret = 'cs_384f9d6eede95af068ba2d9843ce1273255b2dc8';

  //static String url = 'https://jamaa.prokomers.com/wp-json/wc/v3/';
  static String url = 'https://shopzo.prokomers.com/wp-json/wc/v2/';

  // static String tokenUrl =
  //     'https://jamaa.prokomers.com/wp-json/jwt-auth/v1/token';
  static String tokenUrl =
      'https://shopzo.prokomers.com/wp-json/jwt-auth/v1/token';

  //tag endpoints
  static String customerUrl = 'customers';
  static String productsUrl = 'products';
  static String categoriesUrl = 'products/categories';

  static String orderUrl = 'orders';
  static String todayOffersTagID = '20';
  static String topTagID = '21';

//temp
  static String userId = '7';
  static String customerId = '';

// onesignal push notification id
  static String onesignalId = 'bb0605f2-bf8d-46f8-a1df-05b49feaf5e8';

  static String resetPasswordUrl =
      "https://shopzo.prokomers.com/wp-login.php?action=lostpassword";
  static String privacyPolicyUrl =
      'https://sites.google.com/view/shopzo-privacy-policy/home';
  static String termsOfServiceUrl =
      'https://sites.google.com/view/shopzo-terms-of-service/home';

  //customer details api
  //https://jamaa.prokomers.com/wp-json/wc/v3/customers?consumer_key=ck_21a1cfac07deb405f10313a2438da128635f8d80&consumer_secret=cs_868a244eae73cfaebf5beeaefeba2fd0d18074b6
}
