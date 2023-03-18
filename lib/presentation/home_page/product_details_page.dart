import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/data_layer/models/samples/category.dart';
import 'package:shop_x/data_layer/models/samples/image.dart';
import 'package:shop_x/data_layer/models/samples/tag.dart';
import 'package:shop_x/logic_layer/cart_page/cart_page_cubit.dart';
import 'package:shop_x/presentation/home_page/widgets/cart_counter.dart';
import 'package:shop_x/presentation/widgets/navbar.dart';

final _scaffoldKey = GlobalKey();

final size = MediaQuery.of(_scaffoldKey.currentContext!).size;

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage(
      {super.key,
      this.flag = false,
      required this.images,
      required this.name,
      required this.realPrice,
      required this.discountPrice,
      required this.description,
      required this.stock,
      required this.sku,
      this.categories,
      this.tags,
      required this.id});
  final bool flag;
  final String? name;
  final double? realPrice;
  final double? discountPrice;
  final String description;
  final int? stock;
  final String? sku;
  final String id;

  final List<Imagee>? images;
  final List<Category>? categories;
  final List<Tag>? tags;

  String tag = '';

  String category = '';

  List<String> image = [];

  late String parsedDescription;

  late List<Category> parsedCategory;

  late List<Tag> parsedTag;
  int height = 0;
  int width = 0;

  String c = '';

  void getDetails() {
    // retrieve categorys
    // if(categories!.isNotEmpty){
    //  parsedCategory = categories!.sublist(1, categories!.length -1 );
    // }

    categories!.map((Category value) {
      //value.name!.replaceAll(RegExp(r'[]'), '');
      category += '${value.name!} ';

      // return category.add(value.name!);
    }).toList();
    // log(c);

    // retrieve tags
    tags!.map((Tag value) {
      tag += "${value.name!} ";
      //value.name!.replaceAll(RegExp(r'[]'), '');
      // return tag.add(value.name!);
    }).toList();
    // retrieve images
    images!.map((Imagee value) => image.add(value.src!)).toList();

    // remove html elements from description
    RegExp exp =
        RegExp(r'<[^>]*>|&[^;]+;', multiLine: true, caseSensitive: true);
    parsedDescription = description.replaceAll(exp, '').trim();
  }

  @override
  Widget build(BuildContext context) {
    getDetails();

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                      transitionOnUserGestures: true,
                      tag: name!,
                      child: CachedNetworkImage(
                        imageUrl: image.first,
                        imageBuilder: (context, imageProvider) {
                          return Image(
                            //imageProvider,
                            height: size.height * 0.4,
                            width: size.width * 0.8,
                            //imageProvider.
                            fit: BoxFit.fitWidth,
                            image: imageProvider,
                          );
                        },
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )),
                ],
              ),

              Text(
                name!,
                maxLines: 2,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const Spacer(
                flex: 1,
              ),
              RichText(
                text: TextSpan(text: '', children: [
                  TextSpan(
                    text: realPrice.toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 18.0,
                    ),
                  ),
                  const WidgetSpan(
                      child: SizedBox(
                    width: 5,
                  )),
                  TextSpan(
                      text: discountPrice.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ))
                ]),
              ),
              const Divider(thickness: 1),

              Text(
                parsedDescription,
                maxLines: 5,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const Spacer(),

              Text('Availability : $stock in stock',
                  style: TextStyle(color: Colors.grey.shade600)),
              const Spacer(),
              const Divider(
                thickness: 1,
              ),
              // const Spacer(),
              Text('SKU: $sku', style: TextStyle(color: Colors.grey.shade600)),
              const Spacer(
                flex: 1,
              ),
              Text('Categories: $category',
                  style: TextStyle(color: Colors.grey.shade600)),
              const Spacer(),
              Text('Tags: $tag', style: TextStyle(color: Colors.grey.shade600)),

              const Spacer(
                flex: 5,
              ),
              const Spacer(),
              Row(
                children: [
                  CartCounter(
                    numOfProducts: 01,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<CartPageCubit>(context).addToCart(
                            context,
                            name: name!,
                            salePrice: (discountPrice ?? 0.00).toString(),
                            image: image.first,
                            count: CartCounter.updatedCount,
                            id: int.parse(id),
                          );
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(20)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        child: const Text('Add to Cart')),
                    //  BlocBuilder<CartPageCubit, CartPageState>(
                    //   builder: (context, state) {
                    //     log('details');
                    //     log(state.toString());
                    //     if (state is ViewCartPage && state.flag == true) {
                    //       log("view state :${state.flag}");
                    //       return ElevatedButton.icon(
                    //         style: ButtonStyle(
                    //             padding: MaterialStateProperty.all(
                    //                 const EdgeInsets.all(20)),
                    //             shape: MaterialStateProperty.all<
                    //                     RoundedRectangleBorder>(
                    //                 RoundedRectangleBorder(
                    //                     borderRadius:
                    //                         BorderRadius.circular(20)))),
                    //         label: const Text('View Cart'),
                    //         icon: const Icon(Icons.shopping_cart),
                    //         onPressed: () {
                    //           Navigator.pop(context);
                    //           Navbar.notifier.value = 1;

                    //           BlocProvider.of<CartPageCubit>(context).addToCart(
                    //             context,
                    //             name: name!,
                    //             salePrice: (discountPrice ?? 0.00).toString(),
                    //             image: image.first,
                    //             count: CartCounter.updatedCount,
                    //             id: int.parse(id),
                    //           );
                    //         },
                    //       );
                    //     } else {
                    //       return ElevatedButton.icon(
                    //         style: ButtonStyle(
                    //             padding: MaterialStateProperty.all(
                    //                 const EdgeInsets.all(20)),
                    //             shape: MaterialStateProperty.all<
                    //                     RoundedRectangleBorder>(
                    //                 RoundedRectangleBorder(
                    //                     borderRadius:
                    //                         BorderRadius.circular(20)))),
                    //         label: const Text('Add To Cart'),
                    //         icon: const Icon(Icons.shopping_cart),
                    //         onPressed: () {
                    //           BlocProvider.of<CartPageCubit>(context).addToCart(
                    //             context,
                    //             name: name!,
                    //             salePrice: (discountPrice ?? 0.00).toString(),
                    //             image: image.first,
                    //             count: CartCounter.updatedCount,
                    //             id: int.parse(id),
                    //           );
                    //         },
                    //       );
                    //     }
                    //   },
                    // ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navbar.notifier.value = 1;
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(20)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        child: const Text('View Cart')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
