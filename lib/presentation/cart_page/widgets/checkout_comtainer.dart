import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/logic_layer/order_page/bloc/order_page_bloc.dart';
import 'package:sizer/sizer.dart';

Widget buildCheckoutContainer(BuildContext context, num totalCalculation) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    decoration: BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      border:
          Border(top: BorderSide(width: 1, color: Theme.of(context).cardColor)),
    ),
    height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildOrderTotal(context, totalCalculation),
        _buildCheckoutButton(context),
      ],
    ),
  );
}

Widget _buildOrderTotal(BuildContext context, num totalCalculation) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Order Total',
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color,
          fontFamily: 'Lato',
          fontSize: 10.sp,
        ),
      ),
      Text(
        totalCalculation.toString(),
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontWeight: FontWeight.bold,
          fontFamily: 'Lato',
          fontSize: 15.sp,
        ),
      ),
    ],
  );
}

Widget _buildCheckoutButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () async {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Order Confirm?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontFamily: 'Lato',
                        fontSize: 12.sp)),
                content: Text('Are you sure, You want to confirm order',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Lato', fontSize: 10.sp)),
                contentPadding: EdgeInsets.all(8.sp),
                actionsAlignment: MainAxisAlignment.spaceAround,
                actions: [
                  TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        BlocProvider.of<OrderPageBloc>(context, listen: false)
                            .add(CreateOrder(context));
                      },
                      child: Text('Yes',
                          style:
                              TextStyle(fontFamily: 'Lato', fontSize: 10.sp))),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('No',
                          style:
                              TextStyle(fontFamily: 'Lato', fontSize: 10.sp)))
                ],
              ));
    },
    child: Text(
      'Checkout',
      style: TextStyle(
        fontFamily: 'Lato',
        fontSize: 10.sp,
        //  color: Theme.of(context).textTheme.bodyLarge?.color
      ),
    ),
  );
}
