import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_x/data/shop_repository.dart';
import 'package:shop_x/model/samples/sample.dart';
import 'package:shop_x/presentation/cart_page/cart_page.dart';
import 'package:shop_x/presentation/home_page/details_page.dart';
import 'package:shop_x/presentation/home_page/home_page.dart';
import 'package:shop_x/presentation/home_page/widgets/cart_counter.dart';
import 'package:shop_x/presentation/widgets/navbar.dart';

bool flag = false;

class BottomSection extends StatefulWidget {
  const BottomSection({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomSection> createState() => _BottomSectionState();
}

class _BottomSectionState extends State<BottomSection> {
  late Future<List<Sample>?> data;

  @override
  void initState() {
    super.initState();
    data = ShopzoDB.instance.getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sample>?>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1 / 1.8,
              children: List.generate(snapshot.data!.length, (index) {
                final data = snapshot.data![index];
                final image = data.images!;
                final name = data.name!;
                final realPrice = data.regularPrice!;
                final salePrice = data.salePrice!;
                final sku = data.sku!;
                final description = data.description!;
                final stock = data.stockQuantity;
                final tag = data.tags;
                final category = data.categories;

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
                            )));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Hero(
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
                        subtitle: ElevatedButton(
                          onPressed: () {
                            // final product = CartCardWidget(
                            //   name: name,
                            //   price: salePrice,
                            //   image: image.first.src!,
                            //   count: updatedCount,
                            // );
                            //CartPage.cartProducts.add(product);
                            var existingCount;
                            final result =
                                CartPage.cartProducts.indexWhere((element) {
                              existingCount = element.count;
                              return element.name == name;
                            });

                            if (flag == false) {
                              if (result == -1)
                              // && updatedCount == 1)
                              {
                                //updatedCount;
                                final product = CartCardWidget(
                                  name: name,
                                  price: salePrice,
                                  image: image.first.src!,
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
                                      name: name,
                                      price: salePrice != null
                                          ? salePrice.toString()
                                          : 0.toString(),
                                      image: image.first.src!,
                                      count: existingCount + updatedCount,
                                    ));
                              }
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Added to Cart'),
                                duration: Duration(seconds: 1),
                              ));
                            } else {
                              Navbar.notifier.value = 1;
                            }
                          },
                          child: flag == false
                              ? const Text('Add to Cart')
                              : const Text('View Cart'),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          } else if (snapshot.hasError) {
            return const Align(
              alignment: Alignment.center,
              child: Text('Something went wrong'),
            );
          } else {
            return SizedBox(
              height: siz.width * 0.9,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}

// class GridWidget extends StatelessWidget {
//   const GridWidget({Key? key, required this.image})
//       : super(
//           key: key,
//         );

//   final String image;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       child: Container(
//         decoration: BoxDecoration(
//           image:
//               DecorationImage(image: AssetImage(image), fit: BoxFit.scaleDown),
//         ),
//       ),
//     );
//   }
// }
