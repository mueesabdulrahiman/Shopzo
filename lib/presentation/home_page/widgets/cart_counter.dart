import 'dart:developer';

import 'package:flutter/material.dart';

var updatedCount = 1;

class CartCounter extends StatefulWidget {
  CartCounter({super.key, this.numOfProducts = 01});

  int numOfProducts = 01;
  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //widget.numOfProducts = 1;
  }

  @override
  Widget build(BuildContext context) {
    log(widget.numOfProducts.toString());
    //  int result = updatedCount;
    return Row(
      children: [
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (widget.numOfProducts > 1) {
              setState(() {
                updatedCount = (widget.numOfProducts--) - 1;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            widget.numOfProducts.toString().padLeft(2, '0'),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                updatedCount = (widget.numOfProducts++) + 1;
              });
            }),
      ],
    );
  }
}

SizedBox buildOutlineButton(
    {required IconData icon, required VoidCallback press}) {
  return SizedBox(
    width: 38,
    height: 32,
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
