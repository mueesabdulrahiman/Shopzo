import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_x/presentation/cart_page/cart_page.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CartCardWidget extends StatelessWidget {
  CartCardWidget(
      {super.key,
      required this.name,
      required this.price,
      required this.image,
      this.total = 0,
      required this.count,
      required this.id});

  final String name;
  final double price;
  final String image;
  final String id;
  final int count;
  num total;

  num _calculation() {
    total = price * count;
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 23.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.sp),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.5.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: image,
                  imageBuilder: (context, imageProvider) {
                    return Image(
                      image: imageProvider,
                      height: 18.h,
                      width: 38.w,
                      fit: BoxFit.fill,
                    );
                  },
                ),
                SizedBox(
                  width: 5.w,
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
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Lato',
                            fontSize: 12.sp),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Text(_calculation().toString(),
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lato',
                              fontSize: 11.sp)),
                      const Spacer(
                        flex: 1,
                      ),
                      Text(
                        'Qty: $count',
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                            fontSize: 11.sp),
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
          right: 3.w,
          bottom: 0.w,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
             
              TextButton(
                child: Text('Edit',
                    style: TextStyle(fontFamily: 'Lato', fontSize: 10.sp)),
                onPressed: () {
                  _openEditButtonDialog(context);
                },
              ),
              TextButton(
                child: Text(
                  'Remove',
                  style: TextStyle(fontFamily: 'Lato', fontSize: 10.sp),
                ),
                onPressed: () {
                  _openCancelButtonDialog(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<dynamic> _openCancelButtonDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((context) {
          return SimpleDialog(
            title: Text('Are you sure, you want to remove product?',
                style: TextStyle(fontFamily: 'Lato', fontSize: 12.sp)),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        CartPage.cartProductsNotifier.value
                            .removeWhere((element) => element.id == id);
                        CartPage.cartProductsNotifier.notifyListeners();
                        Navigator.of(context).pop();
                      },
                      child: Text('Yes',
                          style:
                              TextStyle(fontFamily: 'Lato', fontSize: 10.sp))),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('No',
                          style:
                              TextStyle(fontFamily: 'Lato', fontSize: 10.sp))),
                ],
              )
            ],
          );
        }));
  }

  void _openEditButtonDialog(BuildContext context) {
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
                style: Theme.of(context).textTheme.titleLarge,
              ),
              actionsAlignment: MainAxisAlignment.spaceAround,
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
                    child: Text('Update',
                        style: TextStyle(fontFamily: 'Lato', fontSize: 10.sp))),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel',
                        style: TextStyle(fontFamily: 'Lato', fontSize: 10.sp)))
              ],
            ));
  }
}
