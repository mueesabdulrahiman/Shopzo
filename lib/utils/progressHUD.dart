import 'package:flutter/material.dart';

class ProgressHUD extends StatelessWidget {
  const ProgressHUD(
      {super.key,
      required this.child,
      required this.inAsyncCall,
      this.opacity = 0.3,
      this.color,
      this.valueColor});

  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color? color;     
  final Animation<Color>? valueColor;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);

    final modal = Stack(
      children: [
        Opacity(
          opacity: opacity,
          child: ModalBarrier(
            dismissible: false,
            color: color,
          ),
        ),
        const Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
    if (inAsyncCall) widgetList.add(modal);
    return Stack(
      children: widgetList,
    );
  }
}
