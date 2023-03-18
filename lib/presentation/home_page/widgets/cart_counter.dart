import 'dart:developer';

import 'package:flutter/material.dart';

class CartCounter extends StatefulWidget {
  CartCounter({super.key, required this.numOfProducts, this.press});
  static int updatedCount = 1;

  int numOfProducts = 1;
  void Function()? press;
  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _textController.text = widget.numOfProducts.toString().padLeft(2, '0');
    });
    log(widget.numOfProducts.toString());

    return Row(
      children: [
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (widget.numOfProducts > 1) {
              setState(() {
                CartCounter.updatedCount = (widget.numOfProducts--) - 1;
              });

              widget.press;
            }
          },
        ),
        GestureDetector(
          onTap: () {
            openDialog();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.numOfProducts.toString().padLeft(2, '0'),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                CartCounter.updatedCount = (widget.numOfProducts++) + 1;
              });
              widget.press;
            }),
      ],
    );
  }

  Future<String?> openDialog() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Update Count'),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: _textController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Enter the quantity'),
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: [
              TextButton(onPressed: submit, child: const Text('Submit')),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'))
            ],
          ));

  submit() {
    if (_textController.text.isEmpty) return;
    setState(() {
      widget.numOfProducts = int.parse(_textController.text);
      CartCounter.updatedCount = int.parse(_textController.text);
    });

    Navigator.pop(context);
    _textController.clear();
  }
}

Widget buildOutlineButton(
    {required IconData icon, required VoidCallback press}) {
  return SizedBox(
    width: 38,
    height: 30,
    child: OutlinedButton(
      style: ButtonStyle(
          side: MaterialStateProperty.all(
              const BorderSide(color: Colors.blue, width: 1)),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ))),
      onPressed: press,
      child: Icon(icon),
    ),
  );
}
