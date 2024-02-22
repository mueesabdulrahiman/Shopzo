import 'package:flutter/material.dart';
import 'package:shop_x/presentation/account_page/about_page.dart';
import 'package:shop_x/presentation/account_page/notifications_page.dart';
import 'package:shop_x/presentation/account_page/edit_profile_page.dart';
import 'package:shop_x/presentation/account_page/setting_page.dart';
import 'package:shop_x/presentation/account_page/widgets/custom_dialog_box.dart';
import 'package:shop_x/presentation/widgets/navbar.dart';
import 'package:shop_x/presentation/widgets/un_auth.dart';
import 'package:shop_x/utils/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class OptionList {
  final String optionTitle;
  final IconData optionIcon;
  final void Function() onTap;
  OptionList(this.optionTitle, this.optionIcon, this.onTap);
}

class _AccountPageState extends State<AccountPage> {
  List<OptionList> optionList = [];

  @override
  void initState() {
    super.initState();
    optionList.add(
      OptionList('Profile', Icons.edit, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => const EditProfilePage()));
      }),
    );
    optionList.add(
      OptionList('About', Icons.info, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => const AboutPage()));
      }),
    );
    optionList.add(
      OptionList('Setting', Icons.settings, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => const SettingPage()));
      }),
    );
    optionList.add(
      OptionList('Notifications', Icons.assignment, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => const NotificationsPage()));
      }),
    );

    optionList.add(
      OptionList('Logout', Icons.logout, () {
        showDialogBox(context, () async {
          Navigator.pop(context);
          await SharedPrefService.logout();
          Navbar.notifier.value = 0;
          Navbar.notifier.notifyListeners();
        }, title: 'Logout?', description: 'Are you sure, you want to logout');
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: SharedPrefService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor,
                  foregroundColor:
                      Theme.of(context).appBarTheme.foregroundColor,
                  elevation: 0,
                  title: Text(
                    'My Account',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato'),
                  ),
                  centerTitle: true,
                ),
                body: FutureBuilder(
                  future: SharedPrefService.isLoggedIn(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _buildListView();
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              );
            } else {
              return const UnAuthWidget();
            }
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  Widget _buildListView() {
    return FutureBuilder(
        future: SharedPrefService.getLoginDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(8.sp),
                  decoration: const BoxDecoration(),
                  child: Container(
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.all(Radius.circular(12.sp))),
                    child: Row(
                      children: [
                        Icon(Icons.account_circle_sharp,
                            color: Colors.green, size: 20.w),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              '${snapshot.data!.data!.displayName}',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Lato'),
                            ),
                            subtitle: Text(
                              snapshot.data?.data?.email.toString() ?? 'Nil',
                              style: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 10.sp),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ListView(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 6.sp),
                    children: optionList
                        .map((option) => Card(
                            color: Theme.of(context).cardColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.sp)),
                            child: _buildRow(option)))
                        .toList()),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _buildRow(OptionList optionList) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Icon(optionList.optionIcon, size: 20.sp, color: Colors.green),
        ),
        title: Text(
          optionList.optionTitle,
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato'),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 20.sp,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
        onTap: optionList.onTap,
      ),
    );
  }
}
