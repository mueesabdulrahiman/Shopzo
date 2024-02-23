import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        title: Text('Order Details',
            style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                fontSize: 15.sp)),
        centerTitle: true,
        automaticallyImplyLeading: true,
      
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          pageUI(),
        ],
      )),
    );
  }

  Widget pageUI() {
    return const SizedBox();
  }
}
