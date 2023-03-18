import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shop_x/logic_layer/cart_page/cart_page_cubit.dart';
import 'package:shop_x/logic_layer/home_page/home_page_bloc.dart';
import 'package:shop_x/messaging.dart';
import 'package:shop_x/presentation/cart_page/cart_page.dart';
import 'package:shop_x/presentation/home_page/product_details_page.dart';
import 'package:shop_x/presentation/home_page/widgets/bottom_section.dart';
import 'package:shop_x/presentation/home_page/widgets/cart_counter.dart';
import 'package:shop_x/presentation/home_page/widgets/drawer.dart';
import 'package:shop_x/presentation/home_page/widgets/header_section.dart';
import 'package:shop_x/presentation/home_page/widgets/middle_section.dart';
import 'package:shop_x/presentation/home_page/widgets/serach_widget.dart';
import 'package:shop_x/presentation/widgets/navbar.dart';

final _scaffoldKey = GlobalKey<ScaffoldState>();
final siz = MediaQuery.of(_scaffoldKey.currentContext!).size;
//const String SAVE_KEY_NAME = 'userLoggedIn';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: ThemeData().iconTheme,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          searchWidget(),
          SizedBox(
            width: size.width * 0.05,
          ),
          GestureDetector(
            onTap: () => Navbar.notifier.value = 1,
            child: const Icon(
              Icons.shopping_basket_outlined,
            ),
          ),
          SizedBox(
            width: size.width * 0.05,
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if (state is SearchedProducts && state.searchProducts.isNotEmpty) {
            log('sea');
            final products = state.searchProducts;

            return GridView.count(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1 / 1.8,
              children: List.generate(products.length, (index) {
                final data = products[index];
                final image = data.images!;
                final name = data.name!;
                final realPrice = data.regularPrice!;
                final salePrice = data.salePrice!;
                final sku = data.sku!;
                final description = data.description!;
                final stock = data.stockQuantity;
                final tag = data.tags;
                final category = data.categories;
                final id = data.id;
                bool flag = data.flag;
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => ProductDetailsPage(
                              categories: category,
                              description: description,
                              discountPrice: double.tryParse(salePrice),
                              name: name,
                              realPrice: double.tryParse(realPrice),
                              sku: sku,
                              stock: stock,
                              tags: tag,
                              images: image,
                              id: id.toString(),
                            )));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Hero(
                        transitionOnUserGestures: true,
                        tag: name,
                        child: CachedNetworkImage(
                          imageUrl: data.images!.first.src!,
                          imageBuilder: (context, imageProvider) => Container(
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.contain,
                                    scale: 1)),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.name!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                )),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: double.tryParse(realPrice).toString(),
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough)),
                              const WidgetSpan(
                                  child: SizedBox(
                                width: 5,
                              )),
                              TextSpan(
                                  text: double.tryParse(salePrice).toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))
                            ])),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CartCounter(numOfProducts: 01),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<CartPageCubit>(context)
                                      .addToCart(context,
                                          name: name,
                                          salePrice: salePrice,
                                          image: image.first.src!,
                                          count: CartCounter.updatedCount,
                                          id: id!);
                                },
                                child: flag
                                    ? const Text('View Cart')
                                    : const Text('Add To Cart'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          } else if (state is SearchedProducts &&
              state.searchProducts.isEmpty) {
            return const Center(
              child: Text('Products is empty'),
            );
          } else if (state is SearchActive) {
            return Container();
          } else if (state is SearchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: [
                SizedBox(
                  height: size.width * 0.38,
                  child: TopSection(size: size),
                ),
                const Divider(
                  thickness: 6.0,
                ),
                SizedBox(
                  height: size.width * 0.02,
                ),
                const Text(
                  'Categories',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: size.width * 0.05,
                ),
                SizedBox(
                  height: size.width * 0.18,
                  child: MiddleSection(size: size),
                ),
                SizedBox(
                  height: size.width * 0.02,
                ),
                const Divider(
                  thickness: 6.0,
                ),
                BottomSection(),
              ],
            );
          }
        },
      ),
    );
  }
}
