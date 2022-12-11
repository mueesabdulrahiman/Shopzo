import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_x/model/samples/category.dart';
import 'package:shop_x/model/samples/image.dart';
import 'package:shop_x/model/samples/tag.dart';
import 'package:shop_x/presentation/cart_page/cart_page.dart';
import 'package:shop_x/presentation/home_page/widgets/bottom_section.dart';
import 'package:shop_x/presentation/home_page/widgets/cart_counter.dart';
import 'package:shop_x/presentation/widgets/navbar.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage(
      {super.key,
      required this.images,
      required this.name,
      required this.realPrice,
      required this.discountPrice,
      required this.description,
      required this.stock,
      required this.sku,
      this.categories,
      this.tags});
  final String? name;
  final double? realPrice;
  final double? discountPrice;
  final String description;
  final int? stock;
  final String? sku;

  final List<Imagee>? images;
  final List<Category>? categories;
  final List<Tag>? tags;
  List<String> tag = [];
  List<String> category = [];
  List<String> image = [];

  late String parsedDescription;
  late List<Category> parsedCategory;
  late List<Tag> parsedTag;

  void getDetails() {
    // retrieve categorys
    // if(categories!.isNotEmpty){
    //  parsedCategory = categories!.sublist(1, categories!.length -1 );
    // }
    categories!.map((Category value) {
      //value.name!.replaceAll(RegExp(r'[]'), '');
      return category.add(value.name!);
    }).toList();

    // retrieve tags
    tags!.map((Tag value) {
      //value.name!.replaceAll(RegExp(r'[]'), '');
      return tag.add(value.name!);
    }).toList();
    // retrieve images
    images!.map((Imagee value) => image.add(value.src!)).toList();
    // remove html elements from description
    RegExp exp =
        RegExp(r'<[^>]*>|&[^;]+;', multiLine: true, caseSensitive: true);
    parsedDescription = description.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    getDetails();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
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
                    tag: name!,
                    child: CachedNetworkImage(
                      imageUrl: image.first,
                      imageBuilder: (context, imageProvider) {
                        return Image(
                          height: size.height * 0.4,
                          fit: BoxFit.fill,
                          image: imageProvider,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 2,
              ),

              Text(
                name!,
                maxLines: 2,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const Spacer(
                flex: 2,
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
              const Spacer(
                flex: 1,
              ),

              Text(
                parsedDescription,
                maxLines: 5,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              // const Spacer(
              //   flex: 1,
              // ),
              Text('Availability : $stock in stock',
                  style: TextStyle(color: Colors.grey.shade600)),
              const Spacer(
                flex: 1,
              ),
              const Divider(
                thickness: 1,
              ),
              const Spacer(
                flex: 1,
              ),
              Text('SKU: $sku', style: TextStyle(color: Colors.grey.shade600)),
              const Spacer(
                flex: 1,
              ),
              Text('Categories: $category',
                  style: TextStyle(color: Colors.grey.shade600)),
              const Spacer(
                flex: 1,
              ),
              Text('Tags: $tag', style: TextStyle(color: Colors.grey.shade600)),

              const Spacer(
                flex: 5,
              ),
              Row(
                children: [
                  CartCounter(
                    numOfProducts: 1,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: ElevatedButton.icon(
                    style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                    label: flag == false
                        ? const Text('Add To Cart')
                        : const Text('View Cart'),
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      if (flag == false) {
                        var existingCount;
                        final result =
                            CartPage.cartProducts.indexWhere((element) {
                          existingCount = element.count;
                          return element.name == name;
                        });

                        log(result.toString());

                        if (result == -1) {
                          // updatedCount =1;

                          //updatedCount;
                          final product = CartCardWidget(
                            name: name!,
                            price: discountPrice.toString(),
                            image: image.first,
                            count: updatedCount,
                          );
                          CartPage.cartProducts.add(product);
                          //print(CartPage.cartProducts[0].name);
                        }
                        //else if (result == -1)
                        //&& updatedCount > 1)
                        // {
                        //   final product = CartCardWidget(
                        //     name: name,
                        //     price: salePrice,
                        //     image: image.first.src!,
                        //     count: updatedCount,
                        //   );
                        //   CartPage.cartProducts.add(product);
                        // }
                        else {
                          //updatedCount = 1;

                          CartPage.cartProducts.removeAt(result);
                          CartPage.cartProducts.insert(
                              result,
                              CartCardWidget(
                                name: name!,
                                price: discountPrice != null
                                    ? discountPrice.toString()
                                    : 0.toString(),
                                image: image.first,
                                count: existingCount + updatedCount++,
                              ));
                        }
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Added to Cart'),
                          duration: Duration(seconds: 1),
                        ));
                      } else {
                        Navigator.pop(context);
                        Navbar.notifier.value = 1;
                      }
                    },
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
