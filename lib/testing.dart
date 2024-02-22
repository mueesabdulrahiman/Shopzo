import 'dart:developer';

import 'package:flutter/material.dart';

var updatedCount = 1;

class Tesing extends StatefulWidget {
  Tesing({super.key, required this.numOfProducts, this.press});

  int numOfProducts;
  void Function()? press;
  @override
  State<Tesing> createState() => _CartCounterState();
}

class _CartCounterState extends State<Tesing> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_textController.text = widget.numOfProducts.toString().padLeft(2, '0');
    //  widget.numOfProducts = 01;
  }

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _textController.text = widget.numOfProducts.toString().padLeft(2, '0');
    });
    log(widget.numOfProducts.toString());
    //  int result = updatedCount;
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildOutlineButton(
              icon: Icons.remove,
              press: () {
                if (widget.numOfProducts > 1) {
                  setState(() {
                    widget.numOfProducts = int.parse(_textController.text);
                    updatedCount = (widget.numOfProducts--) - 1;
                  });
                  widget.press;
                }
              },
            ),
            // SizedBox(
            //   width: 40,
            //   child: TextField(
            //     textAlign: TextAlign.center,
            //     decoration: const InputDecoration(border: InputBorder.none),
            //     controller: _textController,
            //     style: Theme.of(context).textTheme.headline6,
            //   ),
            // ),

            GestureDetector(
              onTap: () async {
                final data = await openDialog();
                widget.numOfProducts = int.parse(data!);
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
                    widget.numOfProducts = int.parse(_textController.text);

                    updatedCount = (widget.numOfProducts++) + 1;
                  });
                  widget.press;
                }),
          ],
        ),
      ),
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
              TextButton(onPressed: () {}, child: const Text('Cancel'))
            ],
          ));

  void submit() {
    if (_textController.text.isEmpty) return;
    Navigator.pop(context, _textController.text);
    _textController.clear();
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
