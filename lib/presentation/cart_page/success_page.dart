import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/logic_layer/order_page/bloc/order_page_bloc.dart';
import 'package:shop_x/presentation/widgets/navbar.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

late Animation<double> animation;
late AnimationController controller;

class _SuccessPageState extends State<SuccessPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrderPageBloc, OrderPageState>(
        builder: (context, state) {
          if (state is OrderCreated) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: animation.value * 100,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: Icon(
                    Icons.check,
                    size: animation.value * 50.0,
                    color: Colors.white,
                  )),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Order Placed Successfully',
                  style: TextStyle(color: Colors.green, fontSize: 20.0),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.green,
                    ),
                    minimumSize: MaterialStateProperty.all(const Size(100, 40)),
                  ),
                  child: const Text('Done'),
                  onPressed: () {
                    Navigator.of(context).pop();

                    Navbar.notifier.value = 0;
                  },
                ),
              ],
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
