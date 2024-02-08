
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shop_x/next_page.dart';
import 'package:shop_x/presentation/main_page.dart';
import 'package:shop_x/presentation/widgets/navbar.dart';
import 'globals.dart' as globals;

class Messaging extends StatefulWidget {
  const Messaging({
    super.key,
  });

  @override
  State<Messaging> createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  static const String oneSignalAppId = 'bb0605f2-bf8d-46f8-a1df-05b49feaf5e8';
  @override
  void initState() {
    super.initState();
   // initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(oneSignalAppId),
      ),
    );
  }
}

// Future<void> initPlatformState() async {
//   OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
//   await OneSignal.shared.setAppId('bb0605f2-bf8d-46f8-a1df-05b49feaf5e8');

//   OneSignal.shared.setNotificationOpenedHandler((openedResult) {
//     var data = openedResult.notification.additionalData;
//     log(data.toString());
//     globals.appNavigator!.currentState!
//         .push(MaterialPageRoute(builder: (context) => NextPage()));
//   });

//   OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
//     event.complete(event.notification);

//     OneSignal.shared.getDeviceState().then((value) => print(value?.userId));
//   });
// }
