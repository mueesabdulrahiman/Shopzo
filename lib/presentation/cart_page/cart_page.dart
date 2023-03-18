import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/data_layer/models/orders.dart';
import 'package:shop_x/logic_layer/order_page/bloc/order_page_bloc.dart';
import 'package:shop_x/presentation/cart_page/success_page.dart';
import 'package:shop_x/presentation/widgets/unAuth.dart';
import 'package:shop_x/utils/shared_preferences.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  static ValueNotifier<List<CartCardWidget>> cartProductsNotifier =
      ValueNotifier([]);

  num totalPrice = 0;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  ApiServices apiServices = ApiServices();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  num calculateTotalPrice() {
    num totalPrice = 0;
    for (final cartProduct in CartPage.cartProductsNotifier.value) {
      totalPrice += cartProduct.price * cartProduct.count;
    }
    return totalPrice;
  }

  bool flag = false;

  @override
  Widget build(BuildContext context) {
    calculateTotalPrice();
    // BlocListener<OrderPageBloc, OrderPageState>(
    //   listener: (context, state) {
    //     if (state is OrderCreated) {
    //       Navigator.push(_scaffoldKey.currentContext!,
    //           MaterialPageRoute(builder: (ctx) => const SuccessPage()));
    //       CartPage.cartProductsNotifier.value.clear();
    //     }
    //   },
    // );
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: SharedPrefService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data! == true) {
              return SafeArea(
                child: CartPage.cartProductsNotifier.value.isNotEmpty
                    ? ValueListenableBuilder(
                        valueListenable: CartPage.cartProductsNotifier,
                        builder: (ctx, value, _) {
                          return Stack(
                            children: [
                              ListView.separated(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 50),
                                itemBuilder: (ctx, index) {
                                  return value[index];
                                },
                                itemCount: value.length,
                                separatorBuilder: (context, index) =>
                                    seperator(),
                              ),
                              Positioned(
                                left: 0,
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          top: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade200))),
                                  height: 60,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Order Total',
                                              style: TextStyle(
                                                  color: Colors.grey[500],
                                                  fontSize: 15.0),
                                            ),
                                            Text(
                                              calculateTotalPrice().toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                // flag = true;

                                                // OrderModel orderModel =
                                                //     OrderModel();
                                                // if (CartPage
                                                //     .cartProductsNotifier
                                                //     .value
                                                //     .isNotEmpty) {
                                                //   final userDetails =
                                                //       await apiServices
                                                //           .getCustomerDetails();
                                                //   log('cus: ${userDetails!.shipping!.toJson()}');

                                                //   if (userDetails.shipping !=
                                                //       null) {
                                                //     log('id: ${userDetails.id}');
                                                //     orderModel.shipping =
                                                //         Shipping1();
                                                //     orderModel.customerId =
                                                //         userDetails.id;

                                                //     orderModel
                                                //             .shipping!.address =
                                                //         userDetails
                                                //             .shipping!.address;
                                                //     orderModel.shipping!.city =
                                                //         userDetails
                                                //             .shipping!.city;
                                                //     orderModel
                                                //             .shipping!.company =
                                                //         userDetails
                                                //             .shipping!.company;
                                                //     orderModel.status =
                                                //         'processing';
                                                //     orderModel.paymentMethod =
                                                //         'Cash On Delivery';
                                                //   }
                                                //   if (orderModel.shipping !=
                                                //       null) {
                                                //     orderModel.lineItems =
                                                //         <LineItems>[];

                                                //     for (final data in CartPage
                                                //         .cartProductsNotifier
                                                //         .value) {
                                                //       final item = LineItems(
                                                //           productId: int.parse(
                                                //               data.id),
                                                //           quantity: data.count);

                                                //       orderModel.lineItems!
                                                //           .add(item);
                                                //     }

                                                //     final result =
                                                //         await apiServices
                                                //             .createOrder(
                                                //                 orderModel);
                                                //     log("order result: $result");
                                                //     flag = false;

                                                BlocProvider.of<OrderPageBloc>(
                                                        _scaffoldKey
                                                            .currentContext!,
                                                        listen: false)
                                                    .add(CreateOrder(_scaffoldKey.currentContext!));
                                                // final state = BlocProvider
                                                //     .of<OrderPageBloc>(context, listen: false)
                                                //     .orderCreated;
                                                // if ( state == true) {
                                                 
                                                //  }

                                                //  }
                                                // }
                                              },
                                              child:
                                                  // const SizedBox(
                                                  //   height: 20,
                                                  //   width: 20,
                                                  //   child:
                                                  //       CircularProgressIndicator(
                                                  //     color: Colors.white,
                                                  //     strokeWidth: 2,
                                                  //   ),
                                                  // ),
                                                  const Text('checkout'),
                                            ),
                                          ],
                                        )
                                      ]),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    : const Center(
                        child: Text('Cart is empty'),
                      ),
              );
            } else {
              return const UnAuthWidget();
            }
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget seperator() {
    return Column(
      children: const [
        SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 1,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class CartCardWidget extends StatelessWidget {
  CartCardWidget(
      {Key? key,
      required this.name,
      required this.price,
      required this.image,
      this.total = 0,
      required this.count,
      required this.id})
      : super(key: key);

  final String name;
  final double price;
  final String image;
  final String id;
  final int count;
  num total;

  // bool flag;

  //int  totalPrice +=   count;

  num _calculation() {
    total = price * count;
    return total;
  }

  @override
  Widget build(BuildContext context) {
    //controller!.text = count.toString();
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.23,
          decoration: BoxDecoration(
            // color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: image,
                  imageBuilder: (context, imageProvider) {
                    return Image(
                      image: imageProvider,
                      height: MediaQuery.of(context).size.height * 0.18,
                      width: MediaQuery.of(context).size.width * 0.38,
                      fit: BoxFit.fill,
                    );
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      Text(
                        name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Text(_calculation().toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      const Spacer(
                        flex: 1,
                      ),
                      // Text('GBZ-S1043144-1-1-1'),
                      // Spacer(),
                      Text(
                        'Qty: $count',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 5,
          bottom: 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                child: const Text('Edit'),
                onPressed: () {
                  openDialog(context);
                },
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return SimpleDialog(
                          title: const Text(
                              'Are you sure, you want to remove product?'),
                          children: [
                            // const Text("Are you Sure"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      CartPage.cartProductsNotifier.value
                                          .removeWhere(
                                              (element) => element.id == id);
                                      CartPage.cartProductsNotifier
                                          .notifyListeners();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Yes')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('No')),
                              ],
                            )
                          ],
                        );
                      }));
                  // ShopzoDB.instance.deleteData(int.parse(id));
                  // CartPage.cartProductsNotifier.value
                  //     .removeWhere((element) => element.id == id);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void openDialog(BuildContext context) {
    final controller = TextEditingController();
    controller.text = count.toString();
    showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Update Count'),
              content: TextField(
                keyboardType: TextInputType.number,
                controller: controller,
                autofocus: true,
                decoration:
                    const InputDecoration(hintText: 'Enter the quantity'),
                style: Theme.of(context).textTheme.headline6,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      final result = CartPage.cartProductsNotifier.value
                          .indexWhere((element) => element.name == name);
                      CartPage.cartProductsNotifier.value.removeAt(result);
                      CartPage.cartProductsNotifier.value.insert(
                          result,
                          CartCardWidget(
                            name: name,
                            price: price,
                            image: image,
                            count: int.parse(controller.text),
                            id: id,
                          ));

                      CartPage.cartProductsNotifier.notifyListeners();

                      Navigator.pop(context);
                    },
                    child: const Text('Submit')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'))
              ],
            ));
  }
}
