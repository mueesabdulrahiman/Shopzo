import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/data_layer/models/samples/category.dart';
import 'package:shop_x/data_layer/models/samples/image.dart';
import 'package:shop_x/data_layer/models/samples/tag.dart';
import 'package:shop_x/logic_layer/cart_page/cart_page_cubit.dart';
import 'package:shop_x/presentation/home_page/widgets/cart_counter.dart';
import 'package:shop_x/presentation/widgets/navbar.dart';
import 'package:sizer/sizer.dart';

final _scaffoldKey = GlobalKey<ScaffoldState>();
final productSize = MediaQuery.of(_scaffoldKey.currentContext!).size;

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

  void getDetails() {
    categories!.map((Category value) {
      category += '${value.name!}, ';
    }).toList();

    // retrieve tags
    tags!.map((Tag value) {
      tag += "${value.name!}, ";
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        title: Text(
          'Product Details',
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
              fontSize: 15.sp),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.sp),
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
                            height: 40.h,
                            width: 80.w,
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
              SizedBox(height: 0.5.h),
              Text(
                name!,
                maxLines: 2,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Lato'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$sku',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontFamily: 'Lato')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(text: '', children: [
                          TextSpan(
                            text: realPrice.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.lineThrough,
                              fontFamily: 'Lato',
                              fontSize: 13.sp,
                            ),
                          ),
                          WidgetSpan(
                              child: SizedBox(
                            width: 2.w,
                          )),
                          TextSpan(
                              text: "₹$discountPrice",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato',
                                fontSize: 14.sp,
                              ))
                        ]),
                      ),
                      Text('$stock in stock',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                              fontFamily: 'Lato',
                              fontSize: 10.sp)),
                    ],
                  ),
                  CartCounter(
                    numOfProducts: 01,
                    height: 4.h,
                    width: 25.w,
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Text(
                parsedDescription,
                maxLines: 5,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontFamily: 'Lato',
                ),
              ),
              Divider(thickness: 0.2.h),
              Text('Categories: $category',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontFamily: 'Lato',
                      fontSize: 10.sp)),
              Text('Tags: $tag',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontFamily: 'Lato',
                      fontSize: 10.sp)),
              const Spacer(),
              Row(
                children: [
                  SizedBox(
                    height: 7.h,
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<CartPageCubit>(context).addToCart(
                          context,
                          name: name!,
                          salePrice: (discountPrice ?? 0.00).toString(),
                          image: image.first,
                          count: CartCounter.updatedCount,
                          id: int.parse(id),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 10.w,
                        child: Center(
                          child: Icon(
                            Icons.shopping_cart,
                            size: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 7.h,
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
                            Navigator.pop(context);
                            Navbar.notifier.value = 1;
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.all(10.sp)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.sp)))),
                          child: Text('Buy Now',
                              style: TextStyle(
                                  fontFamily: 'Lato', fontSize: 12.sp))),
                    ),
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
