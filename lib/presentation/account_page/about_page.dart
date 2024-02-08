import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
          elevation: 0,
          title: Text('Notifications',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
        ),
        body: Center(
            child: Text(
          'No Notifications',
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 10.sp,
              fontFamily: 'Lato'),
        )));
  }
}
