import 'package:flutter/material.dart';
import 'package:shop_x/config.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        title: Text(
          'About',
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
            customListTile(context, title: 'Terms of Service', onTap: () {
              final url = Uri.parse(Config.termsOfServiceUrl);
              launchUrl(url, mode: LaunchMode.inAppWebView);
            }),
            customListTile(context, title: 'Privacy Policy', onTap: () {
              final uri = Uri.parse(Config.privacyPolicyUrl);
              launchUrl(uri, mode: LaunchMode.inAppWebView);
            })
          ],
        ),
      ),
    );
  }

  Widget customListTile(BuildContext context,
      {required String title, required void Function() onTap}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 13.sp,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w500),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        size: 20.sp,
        color: Theme.of(context).textTheme.bodyMedium?.color,
      ),
      onTap: onTap,
    );
  }
}
