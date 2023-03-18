import 'package:flutter/material.dart';
import 'package:shop_x/data_layer/models/orders.dart';
import 'package:shop_x/presentation/order_page.dart/order_details_page.dart';

class OrderPageCard extends StatelessWidget {
  const OrderPageCard({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          _orderStatus(order.status!),
          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(
            height: 5.0,
          ),
          rowWidget(Icons.edit, 'Order ID', order.orderId.toString()),
          const SizedBox(
            height: 10,
          ),
          rowWidget(Icons.today, 'Order Date', order.orderDate.toString()),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              flatButton(
                  Row(children: const [
                    Text('Order Details'),
                    Icon(Icons.chevron_right)
                  ]), () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) =>
                        OrderDetailsPage(orderId: order.orderId!)));
              }),
            ],
          )
        ],
      ),
    );
  }

  Widget iconText(
      IconData icon, String iconLabel, Color iconcolour, Color? textColor) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconcolour,
        ),
        Text(
          iconLabel,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }

  Widget rowWidget(IconData icon, String iconLabel, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        iconText(icon, iconLabel, Colors.blueAccent, null),
        Text(label),
      ],
    );
  }

  Widget flatButton(Widget iconWidget, VoidCallback onPress) {
    return MaterialButton(
      onPressed: onPress,
      shape: const StadiumBorder(),
      color: Colors.green,
      child: iconWidget,
    );
  }

  Widget _orderStatus(String status) {
    late IconData icon;
    late Color color;
    if (status == 'pending' || status == 'processing' || status == 'on-hold') {
      icon = Icons.timer;
      color = Colors.orange;
    } else if (status == 'completed') {
      icon = Icons.check;
      color = Colors.green;
      } else if (status == 'cancelled' ||
          status == 'refunded' ||
          status == 'failed') { 
      icon = Icons.clear;
      color = Colors.redAccent;
    } else {
      icon = Icons.clear;
      color = Colors.redAccent;
    }

    return iconText(icon, 'Order $status', color, color);
  }
}
