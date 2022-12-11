import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_x/presentation/home_page/widgets/bottom_section.dart';
import 'package:shop_x/presentation/home_page/widgets/cart_counter.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  static List<CartCardWidget> cartProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'My Cart',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SafeArea(
        child: cartProducts.isNotEmpty
            ? Stack(
                children: [
                  ListView.separated(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 50),
                    //shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return cartProducts[index];
                    },
                    itemCount: cartProducts.length,
                    separatorBuilder: (context, index) => seperator(),

                    //  [
                    //   // const CartCardWidget(),
                    //   // seperator(),
                    //   // const CartCardWidget(),
                    //   // seperator(),
                    //   // const CartCardWidget(),
                    //   const SizedBox(
                    //     height: 50,
                    //   )
                    // ],
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                  width: 1, color: Colors.grey.shade200))),
                      height: 60,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '678.00',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Checkout'),
                            )
                          ]),
                    ),
                  ),
                ],
              )
            : const Center(
                child: Text('Cart is empty'),
              ),
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
  const CartCardWidget(
      {Key? key,
      required this.name,
      required this.price,
      required this.image,
      required this.count})
      : super(key: key);

  final String name;
  final String price;
  final String image;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            // color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                        image: NetworkImage(
                          //  'https://shopzo.prokomers.com/wp-content/uploads/2022/11/mr-white.png'
                          image,

                          scale: 1,
                        ),
                        fit: BoxFit.fill),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        name,
                        // maxLines: 3,
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                      const Spacer(),
                      Text(price,
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18))),
                      const Spacer(),
                      // Text('GBZ-S1043144-1-1-1'),
                      // Spacer(),
                      CartCounter(
                        numOfProducts: count,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            top: 5,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                flag = true;
              },
            )),
      ],
    );
  }
}
