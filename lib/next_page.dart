import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key,  this.postId});
  final String? postId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Page')),
      body: Center(
        child: Text(postId ?? 'Noti'),
      ),
    );
  }
}
