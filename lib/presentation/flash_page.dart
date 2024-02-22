import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/logic_layer/home_page/home_page_bloc.dart';
import 'package:shop_x/logic_layer/home_page/home_page_event.dart';
import 'package:shop_x/presentation/main_page.dart';
import 'package:shop_x/utils/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class SpalshScreenPage extends StatefulWidget {
  const SpalshScreenPage({super.key});

  @override
  State<SpalshScreenPage> createState() => _SpalshScreenPageState();
}

class _SpalshScreenPageState extends State<SpalshScreenPage> {
  @override
  void initState() {
    super.initState();
    loadApp();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        key: const Key('splash-screen'),
        child: Image.asset('assets/images/shopzo-app.png',
            width: 25.w, height: 25.w),
      ),
    );
  }

  loadApp() async {
    BlocProvider.of<HomePageBloc>(context).add(LoadHomeData());
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(scaffoldKey.currentContext!,
        MaterialPageRoute(builder: (ctx) => const MainPage()));
  }
}
