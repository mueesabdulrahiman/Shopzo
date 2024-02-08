import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/data_layer/models/samples/sample.dart';
import 'package:shop_x/logic_layer/cart_page/cart_page_cubit.dart';
import 'package:shop_x/presentation/home_page/product_details_page.dart';
import 'package:shop_x/presentation/home_page/widgets/cart_counter.dart';
import 'package:sizer/sizer.dart';

class BottomSection extends StatefulWidget {
  const BottomSection({super.key, required this.products});

  static late ValueNotifier<List<Sample>> clickedCategoryProducts;

  final List<Sample> products;

  @override
  State<BottomSection> createState() => _BottomSectionState();
}

class _BottomSectionState extends State<BottomSection> {
  @override
  void initState() {
    BottomSection.clickedCategoryProducts = ValueNotifier([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: BottomSection.clickedCategoryProducts,
      builder: (con, res, _) {
        return _buildProductList(
            context, res.isNotEmpty ? res : widget.products);
      },
    );
  }
}

_buildProductList(BuildContext context, List<Sample> products) {
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
                    imageBuilder: (context, imageProvider) => Container(
                      // height: 200,
                      // height: double.infinity / 2,

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
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.sp, vertical: 8.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Lato',
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: double.tryParse(realPrice).toString(),
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Lato',
                                fontSize: 12.sp,
                                decoration: TextDecoration.lineThrough)),
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
                      ])),
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
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          onPressed: () {
                            BlocProvider.of<CartPageCubit>(context).addToCart(
                                context,
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
}


