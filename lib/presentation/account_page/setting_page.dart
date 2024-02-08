import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/logic_layer/theme/theme_bloc.dart';
import 'package:sizer/sizer.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  bool _showNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(
              fontSize: 15.sp, fontFamily: 'Lato', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Dark Mode',
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500)),
              trailing: Switch(
                activeColor: Colors.green,
                value: context.watch<ThemeBloc>().state == ThemeMode.dark,
                onChanged: (value) {
                  context.read<ThemeBloc>().add(ThemeChanged(value));
                },
              ),
            ),
            ListTile(
              title: Text(
                'Show Notifications',
                style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500),
              ),
              trailing: Switch(
                activeColor: Colors.green,
                value: _showNotifications,
                onChanged: (value) {
                  setState(() {
                    _showNotifications = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
