import 'package:flutter/material.dart';
import 'package:shop_x/utils/generic.dart';

class VerifyPage extends BasePage {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends BasePageState<VerifyPage> {
  @override
  Widget pageUI() {
    return const Center(child: Text('verify Page'));
  }
}
