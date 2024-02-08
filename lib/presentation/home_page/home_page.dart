import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/logic_layer/cart_page/cart_page_cubit.dart';
import 'package:shop_x/logic_layer/home_page/home_page_bloc.dart';
import 'package:shop_x/logic_layer/home_page/home_page_event.dart';
import 'package:shop_x/presentation/home_page/product_details_page.dart';
import 'package:shop_x/presentation/home_page/widgets/bottom_section.dart';
import 'package:shop_x/presentation/home_page/widgets/cart_counter.dart';
import 'package:shop_x/presentation/home_page/widgets/drawer.dart';
import 'package:shop_x/presentation/home_page/widgets/header_section.dart';
import 'package:shop_x/presentation/home_page/widgets/middle_section.dart';
import 'package:shop_x/presentation/home_page/widgets/serach_widget.dart';
import 'package:shop_x/presentation/widgets/navbar.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeSize = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      
     
    });

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(5.sp),
          child: Image.asset(
            'assets/images/shopzo-app.png',
          ),
        ),
        actions: [
          searchWidget(),
          SizedBox(
            width: 5.w,
          ),
          GestureDetector(
            onTap: () => Navbar.notifier.value = 1,
            child: Icon(
              Icons.shopping_basket_outlined,
              size: 17.sp,
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
        ],
      ),
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if (state is SearchedProducts && state.searchProducts.isNotEmpty) {
            final products = state.searchProducts;
            final device = SizerUtil.deviceType == DeviceType.mobile ? 2 : 3;

            return GridView.count(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 5.sp),
              crossAxisCount: device,
              mainAxisSpacing: 1.w,
              crossAxisSpacing: 1.w,
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
                  child: Card(
                    color: Theme.of(context).cardColor,
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Hero(
                            tag: name,
                            child: CachedNetworkImage(
                              imageUrl: data.images!.first.src!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fitHeight,
                                        scale: 1)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.sp, vertical: 8.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.name!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Lato',
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                RichText(
                                    text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: double.tryParse(realPrice)
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Lato',
                                            fontSize: 12.sp,
                                            decoration:
                                                TextDecoration.lineThrough)),
                                    WidgetSpan(
                                        child: SizedBox(
                                      width: 2.0.w,
                                    )),
                                    TextSpan(
                                        text: '₹$salePrice',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.color,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Lato',
                                            fontSize: 12.sp))
                                  ],
                                )),
                                const Spacer(
                                  flex: 2,
                                ),
                                CartCounter(
                                  numOfProducts: 01,
                                  height: 4.h,
                                  width: double.infinity,
                                ),
                                const Spacer(
                                  flex: 2,
                                ),
                                SizedBox(
                                  height: 4.h,
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
                                    child: Text(
                                      'Add To Cart',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          } else if (state is SearchedProducts &&
              state.searchProducts.isEmpty) {
            return Center(
              child: Text(
                'No Products',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 10.sp,
                    fontFamily: 'Lato'),
              ),
            );
          } else if (state is SearchActive) {
            return Container();
          } else if (state is HomeDataLoaded &&
              state.products.isNotEmpty &&
              state.categories.isNotEmpty) {
            return BlocBuilder<HomePageBloc, HomePageState>(
              builder: (context, state) {
                final currentState = state as HomeDataLoaded;

                return ListView(
                  children: [
                    SizedBox(
                      height: 20.h,
                      child: TopSection(size: homeSize),
                    ),
                    Divider(
                      thickness: 1.h,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Categories',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Lato',
                              fontSize: 13.sp,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              BottomSection.clickedCategoryProducts.value = [];
                            },
                            child: Text(
                              'Show all',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Lato',
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1.h),
                    SizedBox(
                      height: 11.h,
                      child: MiddleSection(
                        size: homeSize,
                        categories: currentState.categories,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Divider(
                      thickness: 6.0.sp,
                    ),
                    BottomSection(
                      products: currentState.products,
                    ),
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
