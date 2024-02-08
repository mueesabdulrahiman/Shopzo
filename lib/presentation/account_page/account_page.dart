import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/logic_layer/authentication/authentication_bloc.dart';
import 'package:shop_x/presentation/account_page/about_page.dart';
import 'package:shop_x/presentation/account_page/edit_profile_page.dart';
import 'package:shop_x/presentation/account_page/setting_page.dart';
import 'package:shop_x/presentation/account_page/widgets/custom_dialog_box.dart';
import 'package:shop_x/presentation/widgets/unAuth.dart';
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
  final VoidCallback onTap;
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
        showDialogBox(context, (){},
            title: 'Logout?', description: 'Are you sure, you want to logout');
      }),
    );
    optionList.add(
      OptionList('Delete Account', Icons.delete, () async {
        showDialogBox(context, (){
          context.read<AuthenticationBloc>().add(DeleteCustomerDetails());
        },
            title: 'Confirm?',
            description: 'Are you sure, you want to remove your account');
        
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
                  child:
                      // Padding(
                      //   padding: EdgeInsets.fromLTRB(6.sp, 6.sp, 6.sp, 0),
                      //   child: Card(
                      //     //margin: EdgeInsets.fromLTRB(6.sp, 6.sp, 6.sp, 0.sp),
                      //     color: Theme.of(context).cardColor,
                      //     elevation: 0,
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(12.sp)),
                      //     child: Padding(
                      //       padding: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                      //       child: ListTile(
                      //         leading: Padding(
                      //           padding: EdgeInsets.all(0.sp),
                      //           child: Icon(
                      //             Icons.account_circle_sharp,
                      //             color:
                      //                 Theme.of(context).textTheme.bodyMedium?.color,
                      //             //Theme.of(context).textTheme.bodyLarge?.color,
                      //             size: 10.w,
                      //           ),
                      //         ),
                      //         title: Text(
                      //           'Hello, ${snapshot.data!.data!.displayName}',
                      //           style: TextStyle(
                      //               fontSize: 15.sp,
                      //               fontWeight: FontWeight.bold,
                      //               fontFamily: 'Lato'),
                      //         ),
                      //       ),
                      //     ),
                      Row(
                    // mainAxisAlignment: MainAxisAlignment,
                    children: [
                      // CircleAvatar(
                      //     backgroundColor: Colors.black,
                      //     radius: 5.w,
                      //     child: Icon(
                      //       Icons.account_circle_sharp,
                      //       color: Colors.white,
                      //       size: 8.w,
                      //     )),
                      Icon(
                        Icons.account_circle_sharp,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        size: 10.w,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        'Hello, ${snapshot.data!.data!.displayName}',
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato'),
                      ),
                    ],
                  ),
                ),
                // ),
                //  ),
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
          child: Icon(
            optionList.optionIcon,
            size: 20.sp,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        title: Text(
          optionList.optionTitle,
          style: TextStyle(
              color: optionList.optionTitle.contains('Delete Account')
                  ? Colors.red
                  : Theme.of(context).textTheme.bodyLarge?.color,
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
