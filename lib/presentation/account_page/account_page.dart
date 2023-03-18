import 'package:flutter/material.dart';
import 'package:shop_x/presentation/account_page/about_page.dart';
import 'package:shop_x/presentation/account_page/edit_profile_page.dart';
import 'package:shop_x/presentation/account_page/setting_page.dart';
import 'package:shop_x/presentation/main_page.dart';
import 'package:shop_x/presentation/widgets/unAuth.dart';
import 'package:shop_x/utils/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class OptionList {
  final String optionTitle;
  final String optionSubTitle;
  final IconData optionIcon;
  final VoidCallback onTap;
  OptionList(
      this.optionTitle, this.optionSubTitle, this.optionIcon, this.onTap);
}

class _AccountPageState extends State<AccountPage> {
  List<OptionList> optionList = [];

  @override
  void initState() {
    super.initState();
    optionList.add(
      OptionList('Edit Profile', 'Update your profile', Icons.edit, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => const EditProfilePage()));
      }),
    );
    optionList.add(
      OptionList('Setting', 'Configure your application', Icons.settings, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => const SettingPage()));
      }),
    );
    optionList.add(
      OptionList('About', 'More details about the app', Icons.assignment, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => const AboutPage()));
      }),
    );
    optionList.add(
      OptionList('Sign Out', 'Logout from device', Icons.logout, () {
        showDialogBox(context);
        //SharedPrefService.logout().then((value) => setState(() {}));
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'My Account',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: FutureBuilder<bool>(
              future: SharedPrefService.isLoggedIn(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return _buildListView();
                  } else {
                    return const UnAuthWidget();
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })),
    );
  }

  Widget _buildRow(OptionList optionList) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            optionList.optionIcon,
            size: 30,
          ),
        ),
        title: Text(
          optionList.optionTitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          optionList.optionSubTitle,
          style: const TextStyle(fontSize: 14, color: Colors.redAccent),
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: optionList.onTap,
      ),
    );
  }

  Widget _buildListView() {
    return FutureBuilder(
        future: SharedPrefService.loginDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    'Welcome, ${snapshot.data!.data!.displayName} ',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: optionList.length,
                    itemBuilder: (context, index) {
                      return Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                          child: _buildRow(optionList[index]));
                    }),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void showDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Logout ?'),
            content: const Text('Are you sure, You want to logout'),
            contentPadding: const EdgeInsets.all(10),
            actions: [
              TextButton(
                  onPressed: () => SharedPrefService.logout()
                      .then((value) => setState(() {})),
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('No'))
            ],
          );
        });
  }
}
