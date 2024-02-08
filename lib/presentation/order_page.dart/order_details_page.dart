import 'package:flutter/material.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/data_layer/models/order_details_model.dart';
import 'package:shop_x/presentation/widgets/checkpoints.dart';
import 'package:shop_x/utils/generic.dart';
import 'package:sizer/sizer.dart';

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
      padding: EdgeInsets.all(8.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("#${model.orderId}", style: orderDetailsPageHeadingStyle()),
          Text(model.orderDate.toString(), style: orderDetailsPageTextStyle()),
          SizedBox(
            height: 2.h,
          ),
          Text('Delivered To', style: orderDetailsPageHeadingStyle()),
          Text(model.shipping!.address1 ?? 'Nil',
              style: orderDetailsPageTextStyle()),
          Text(model.shipping!.city ?? 'Nil',
              style: orderDetailsPageTextStyle()),
          SizedBox(
            height: 2.h,
          ),
          Text('Payment Method', style: orderDetailsPageHeadingStyle()),
          Text(model.paymentMethod ?? 'Nil',
              style: orderDetailsPageTextStyle()),
          const Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: 0.5.h,
          ),
          CheckPoints(
              checkTill: statusPoint,
              checkPoints: const ['Processing', 'Shipping', 'Delivered'],
              checkPointsFillColor: Colors.green),
          const Divider(color: Colors.grey),
          _listOrderItems(model),
          const Divider(color: Colors.grey),
          _itemTotal(
            "Item Total",
            "${model.itemTotalAmount}",
          ),
          _itemTotal(
            'Shipping Charges',
            "${model.shippingTotal}",
          ),
          _itemTotal(
            'Paid',
            '${model.totalAmount}',
          )
        ],
      ),
    );
  }

  TextStyle orderDetailsPageTextStyle() {
    return TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.bold,
        fontSize: 10.sp,
        color: Theme.of(context).textTheme.bodyLarge?.color
        // Colors.black
        );
  }

  TextStyle orderDetailsPageHeadingStyle() {
    return TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.bold,
        fontSize: 11.sp,
        color: Theme.of(context).primaryColor
        //Colors.green
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
      contentPadding: EdgeInsets.all(1.sp),
      title: Text(
        product.productName ?? 'Nil',
        style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontFamily: 'Lato',
            fontSize: 10.sp,
            fontWeight: FontWeight.w300),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(1),
        child: Text('Qty: ${product.quantity}',
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontFamily: 'Lato',
                fontSize: 10.sp,
                fontWeight: FontWeight.w300)),
      ),
      trailing: Text("Rs ${product.totalCost}",
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontFamily: 'Lato',
              fontSize: 10.sp,
              fontWeight: FontWeight.w300)),
    );
  }

  Widget _itemTotal(
    String label,
    String value,
  ) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      contentPadding: const EdgeInsets.fromLTRB(2, -10, 2, -10),
      title: Text(
        label,
        style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontFamily: 'Lato',
            fontSize: 10.sp),
      ),
      trailing: Text(
        "Rs $value",
        style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontFamily: 'Lato',
            fontSize: 10.sp),
      ),
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
      fontFamily: 'Lato',
      color: Color.fromARGB(255, 228, 31, 17),
      fontWeight: FontWeight.bold);

  TextStyle get labelText => const TextStyle(
        fontSize: 14,
        fontFamily: 'Lato',
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );

  TextStyle get productItemText => TextStyle(
        fontSize: 10.sp,
        fontFamily: 'Lato',
        color: Colors.black,
        fontWeight: FontWeight.w600,
      );
  TextStyle get itemTotalText => TextStyle(
      fontSize: 10.sp,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: 'Lato');

  TextStyle get itemTotalPaidText => TextStyle(
        fontSize: 10.sp,
        fontFamily: 'Lato',
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );
}
