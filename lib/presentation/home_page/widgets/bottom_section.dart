import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_x/logic_layer/cart_page/cart_page_cubit.dart';
import 'package:shop_x/logic_layer/home_page/home_page_bloc.dart';
import 'package:shop_x/logic_layer/home_page/home_page_event.dart';
import 'package:shop_x/presentation/home_page/home_page.dart';
import 'package:shop_x/presentation/home_page/product_details_page.dart';
import 'package:shop_x/presentation/home_page/widgets/cart_counter.dart';

//bool flag = false;

class BottomSection extends StatelessWidget {
  
        BottomSection({
    Key? key,
  }) : super(key: key);

  String buttonText = "Add to Cart";

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomePageBloc>(context).add(FetchProducts());
    });
    return _buildProductList(context);
  }
}

_buildProductList(BuildContext context) {
  return BlocBuilder<HomePageBloc, HomePageState>(
    builder: (_, state) {
      if (state is ProductsLoading) {
        return SizedBox(
          height: MediaQuery.of(context).size.width * 0.9,
          child: const Center(child: CircularProgressIndicator()),
        );
      } else if (state is ProductsLoaded) {
        final products = state.products;

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
                                  fontSize: 16, fontWeight: FontWeight.w700),
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
                          child:  ElevatedButton(
                                onPressed: () { 
                                  BlocProvider.of<CartPageCubit>(context)
                                      .addToCart(context,
                                          name: name,
                                          salePrice: salePrice,
                                          image: image.first.src!,
                                          count: CartCounter.updatedCount,
                                          id: id!);

                                  // var existingCount;
                                  // final result = CartPage.cartProductsNotifier.value
                                  //     .indexWhere((product) {
                                  //   existingCount = product.count;
                                  //   return product.name == name;
                                  // });

                                  // if (result == -1) {
                                  //   final product = CartCardWidget(
                                  //     name: name,
                                  //    price: double.tryParse(salePrice) ?? 0.00,
                                  //     image: image.first.src!,
                                  //     count: CartCounter.updatedCount,
                                  //     id: id.toString(),
                                  //   );
                                  //   CartPage.cartProductsNotifier.value
                                  //       .add(product);
                                  //   CartCounter.updatedCount = 1;

                                  //   ScaffoldMessenger.of(context)
                                  //       .showSnackBar(const SnackBar(
                                  //     content: Text('Added to Cart'),
                                  //     duration: Duration(milliseconds: 800),
                                  //   ));
                                  // } else {
                                  //   CartPage.cartProductsNotifier.value
                                  //       .removeAt(result);
                                  //   CartPage.cartProductsNotifier.value.insert(
                                  //       result,
                                  //       CartCardWidget(
                                  //         name: name,
                                  //         price: double.tryParse(salePrice) ?? 0,
                                  //         image: image.first.src!,
                                  //         count: existingCount +
                                  //             CartCounter.updatedCount,
                                  //         id: id.toString(),
                                  //       ));
                                  //   CartCounter.updatedCount = 1;
                                  //   ScaffoldMessenger.of(context)
                                  //       .showSnackBar(const SnackBar(
                                  //     content: Text('Cart Product Updated'),
                                  //     duration: Duration(milliseconds: 800),
                                  //   ));
                                  // }
                                },
                                child: 
                                    const Text('Add To Cart'),
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
      } else {
        //  if (state is ProductsListError) {
        return const Align(
          alignment: Alignment.center,
          child: Text('error'),
        );
      }
      // else {
      //     return   SizedBox(
      //            height: siz.width * 0.9,
      //           child: const Center(child: CircularProgressIndicator()),
      //     );
      //   }
    },
  );
}


// FutureBuilder<List<Sample>?>(
    //     future: data,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return GridView.count(
    //           physics: const ScrollPhysics(),
    //           shrinkWrap: true,
    //           crossAxisCount: 2,
    //           mainAxisSpacing: 5,
    //           crossAxisSpacing: 5,
    //           childAspectRatio: 1 / 2,
    //           children: List.generate(snapshot.data!.length, (index) {
    //             final data = snapshot.data![index];
    //             final image = data.images!;
    //             final name = data.name!;
    //             final realPrice = data.regularPrice!;
    //             final salePrice = data.salePrice!;
    //             final sku = data.sku!;
    //             final description = data.description!;
    //             final stock = data.stockQuantity;
    //             final tag = data.tags;
    //             final category = data.categories;
    //             final id = data.id;
    //             bool flag = data.flag;

    //             return GestureDetector(
    //               onTap: () {
    //                 Navigator.of(context).push(MaterialPageRoute(
    //                     builder: (ctx) => ProductDetailsPage(
    //                           categories: category,
    //                           description: description,
    //                           discountPrice: double.tryParse(salePrice),
    //                           name: name,
    //                           realPrice: double.tryParse(realPrice),
    //                           sku: sku,
    //                           stock: stock,
    //                           tags: tag,
    //                           images: image,
    //                           id: id.toString(),
    //                         )));
    //               },
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Hero(
    //                     tag: name,
    //                     child: CachedNetworkImage(
    //                       imageUrl: data.images!.first.src!,
    //                       imageBuilder: (context, imageProvider) => Container(
    //                         height: 200,
    //                         decoration: BoxDecoration(
    //                             color: Colors.white,
    //                             image: DecorationImage(
    //                                 image: imageProvider,
    //                                 fit: BoxFit.contain,
    //                                 scale: 1)),
    //                       ),
    //                     ),
    //                   ),
    //                   ListTile(
    //                     title: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(data.name!,
    //                             maxLines: 2,
    //                             overflow: TextOverflow.ellipsis,
    //                             style: GoogleFonts.lato(
    //                               textStyle: const TextStyle(
    //                                   fontSize: 16,
    //                                   fontWeight: FontWeight.w700),
    //                             )),
    //                         RichText(
    //                             text: TextSpan(children: [
    //                           TextSpan(
    //                               text: double.tryParse(realPrice).toString(),
    //                               style: const TextStyle(
    //                                   color: Colors.grey,
    //                                   fontWeight: FontWeight.bold,
    //                                   decoration: TextDecoration.lineThrough)),
    //                           const WidgetSpan(
    //                               child: SizedBox(
    //                             width: 5,
    //                           )),
    //                           TextSpan(
    //                               text: double.tryParse(salePrice).toString(),
    //                               style: const TextStyle(
    //                                   color: Colors.black,
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 16))
    //                         ])),
    //                       ],
    //                     ),
    //                     subtitle: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         CartCounter(numOfProducts: 01),
    //                         SizedBox(
    //                           width: double.infinity,
    //                           child: ElevatedButton(
    //                             onPressed: () {
    //                               var existingCount;
    //                               final result = CartPage
    //                                   .cartProductsNotifier.value
    //                                   .indexWhere((product) {
    //                                 existingCount = product.count;
    //                                 return product.name == name;
    //                               });

    //                               if (result == -1) {
    //                                 final product = CartCardWidget(
    //                                   name: name,
    //                                   price: double.tryParse(salePrice) ?? 0.00,
    //                                   image: image.first.src!,
    //                                   count: updatedCount,
    //                                   id: id.toString(),
    //                                 );
    //                                 CartPage.cartProductsNotifier.value
    //                                     .add(product);
    //                                 updatedCount = 1;

    //                                 ScaffoldMessenger.of(context)
    //                                     .showSnackBar(const SnackBar(
    //                                   content: Text('Added to Cart'),
    //                                   duration: Duration(milliseconds: 800),
    //                                 ));
    //                               } else {
    //                                 CartPage.cartProductsNotifier.value
    //                                     .removeAt(result);
    //                                 CartPage.cartProductsNotifier.value.insert(
    //                                     result,
    //                                     CartCardWidget(
    //                                       name: name,
    //                                       price:
    //                                           double.tryParse(salePrice) ?? 0,
    //                                       image: image.first.src!,
    //                                       count: existingCount + updatedCount,
    //                                       id: id.toString(),
    //                                     ));
    //                                 updatedCount = 1;
    //                                 ScaffoldMessenger.of(context)
    //                                     .showSnackBar(const SnackBar(
    //                                   content: Text('Cart Product Updated'),
    //                                   duration: Duration(milliseconds: 800),
    //                                 ));
    //                               }
    //                             },
    //                             child: flag
    //                                 ? const Text('View Cart')
    //                                 : const Text('Add To Cart'),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             );
    //           }),
    //         );
    //       } else if (snapshot.hasError) {
    //         return const Align(
    //           alignment: Alignment.center,
    //           child: Text('Something went wrong'),
    //         );
    //       } else {
    //         return SizedBox(
    //           height: siz.width * 0.9,
    //           child: const Center(child: CircularProgressIndicator()),
    //         );
    //       }
    //     });