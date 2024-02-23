import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/logic_layer/authentication/authentication_bloc.dart';
import 'package:shop_x/logic_layer/theme/theme_bloc.dart';
import 'package:shop_x/presentation/account_page/widgets/custom_dialog_box.dart';
import 'package:shop_x/presentation/account_page/widgets/toast_widget.dart';
import 'package:shop_x/presentation/widgets/navbar.dart';
import 'package:shop_x/utils/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  SettingPageState createState() => SettingPageState();
}

final settingPageKey = GlobalKey<ScaffoldState>();

class SettingPageState extends State<SettingPage> {
  bool _showNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: settingPageKey,
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
        padding: EdgeInsets.all(8.sp),
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
            ListTile(
                title: Text(
                  'Delete account',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 13.sp,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  showDialogBox(context, () async {
                    final navigator = Navigator.of(context);
                    context
                        .read<AuthenticationBloc>()
                        .add(DeleteCustomerDetails());

                    await Future.delayed(Duration.zero);
                    await SharedPrefService.logout();
                    showToastMessage('Account deleted');
                    Navbar.notifier.value = 0;
                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                    Navbar.notifier.notifyListeners();
                    navigator.pop();
                    Navigator.of(settingPageKey.currentContext!).pop();
                  },
                      title: 'Confirm?',
                      description:
                          'Are you sure, you want to delete your account permanently');
                }),
          ],
        ),
      ),
    );
  }
}
