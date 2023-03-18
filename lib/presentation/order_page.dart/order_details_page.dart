import 'package:flutter/material.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/data_layer/models/order_details_model.dart';
import 'package:shop_x/presentation/widgets/checkpoints.dart';
import 'package:shop_x/utils/generic.dart';

class OrderDetailsPage extends BasePage {
  final int orderId;

  const OrderDetailsPage({super.key, required this.orderId});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends BasePageState<OrderDetailsPage> {
  late ApiServices apiservice;
  late int statusPoint;
  @override
  void initState() {
    super.initState();

    apiservice = ApiServices();
  }

  @override
  Widget pageUI() {
    return FutureBuilder(
      future: apiservice.getOrderDetails(widget.orderId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return orderDetailsUI(snapshot.data!);
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height, 
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
    // OrderDetailsModel orderDetailsModel = OrderDetailsModel();
    // orderDetailsModel.orderId = 1;
    // orderDetailsModel.orderDate = DateTime.parse('2023-03-11');
    // orderDetailsModel.paymentMethod = 'Cash On Delivery';
    // orderDetailsModel.shipping = Shipping();
    // orderDetailsModel.shipping!.address1 = 'Thalanagar, Ksd';
    // orderDetailsModel.shipping!.address2 = 'Hampankatte, Mangalore';
    // orderDetailsModel.shipping!.city = 'Kasaragod';
    // orderDetailsModel.lineItems = [];
    // orderDetailsModel.lineItems!.add(LineItems(
    //   productId: 1,
    //   productName: 'Test1',
    //   quantity: 10,
    //   totalCost: 500,
    // ));
    // orderDetailsModel.lineItems!.add(LineItems(
    //   productId: 2,
    //   productName: 'Test2',
    //   quantity: 20,
    //   totalCost: 5000,
    // ));
    // orderDetailsModel.shippingTotal = 100.0;
    // orderDetailsModel.totalAmount = 1000.0;
    // return Scaffold(
    //     appBar: AppBar(
    //       elevation: 0,
    //       title: const Text('order Details'),
    //       centerTitle: true,
    //     ),
    //     body: orderDetailsUI(orderDetailsModel));
  }

  Widget orderDetailsUI(OrderDetailsModel model) {
    getCurrentStatus(model.orderStatus!);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "#${model.orderId}",
            style: Theme.of(context).textTheme.labelHeading,
          ),
          Text(
            model.orderDate.toString(),
            style: Theme.of(context).textTheme.labelText,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Delivered To',
            style: Theme.of(context).textTheme.labelHeading,
          ),
          Text(
            model.shipping!.address1 ?? 'Nil',
            style: Theme.of(context).textTheme.labelText,
          ),
          //Text(model.shipping!.address2!),
          Text(
            model.shipping!.city ?? 'Nil',
            style: Theme.of(context).textTheme.labelText,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Payment Method',
            style: Theme.of(context).textTheme.labelHeading,
          ),
          Text(
            model.paymentMethod ?? 'Nil',
            style: Theme.of(context).textTheme.labelText,
          ),
          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(
            height: 5.0,
          ),
          CheckPoints(
              checkTill: statusPoint,
              checkPoints: const ['Processing', 'Shipping', 'Delivered'],
              checkPointsFillColor: Colors.green),
          const Divider(
            color: Colors.grey,
          ),
          _listOrderItems(model),
          const Divider(
            color: Colors.grey,
          ),
          _itemTotal(
            "Item Total",
            "${model.itemTotalAmount}",
            textStyle: Theme.of(context).textTheme.itemTotalText,
          ),
          _itemTotal(
            'Shipping Charges',
            "${model.shippingTotal}",
            textStyle: Theme.of(context).textTheme.itemTotalText,
          ),
          _itemTotal(
            'Paid',
            '${model.totalAmount}',
            textStyle: Theme.of(context).textTheme.itemTotalPaidText,
          )
        ],
      ),
    );
  }

  Widget _listOrderItems(OrderDetailsModel model) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: model.lineItems?.length ?? 0,
        itemBuilder: (context, index) {
          return _productItems(model.lineItems![index]);
        });
  }

  Widget _productItems(LineItems product) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.all(2),
      onTap: () {},
      title: Text(
        product.productName ?? 'Nil',
        style: Theme.of(context).textTheme.productItemText,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(1),
        child: Text('Qty: ${product.quantity}'),
      ),
      trailing: Text("Rs ${product.totalCost}"),
    );
  }

  Widget _itemTotal(String label, String value,
      {required TextStyle textStyle}) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      contentPadding: const EdgeInsets.fromLTRB(2, -10, 2, -10),
      title: Text(
        label,
        style: textStyle,
      ),
      trailing: Text("Rs $value"),
    );
  }

  void getCurrentStatus(String status) {
    if (status == 'processing' || status == 'on-hold') {
      statusPoint = 0;
    } else if (status == 'cancelled' ||
        status == 'refunded' ||
        status == 'failed') {
      statusPoint = -1;
    } else if (status == 'pending') {
      statusPoint = 1;
    } else if (status == 'completed') {
      statusPoint = 2;
    } else {
      statusPoint = 0;
    }
  }
}

extension CustomStyles on TextTheme {
  TextStyle get labelHeading => const TextStyle(
      fontSize: 16,
      color: Color.fromARGB(255, 228, 31, 17),
      fontWeight: FontWeight.bold);

  TextStyle get labelText => const TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );

  TextStyle get productItemText => const TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      );
  TextStyle get itemTotalText => const TextStyle(
      fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600);

  TextStyle get itemTotalPaidText => const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );
}
