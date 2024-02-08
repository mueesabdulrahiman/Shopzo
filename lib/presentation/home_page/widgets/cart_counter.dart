import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CartCounter extends StatefulWidget {
  CartCounter({
    super.key,
    required this.numOfProducts,
    required this.height,
    required this.width,
    this.press,
  });
  static int updatedCount = 1;

  int numOfProducts = 1;
  void Function()? press;
  final double height;
  final double width;
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

    return Card(
      color: Colors.green.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.sp),
      ),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                padding: EdgeInsets.symmetric(horizontal: 5.sp),
                child: Center(
                  child: Text(
                    widget.numOfProducts.toString().padLeft(2, '0'),
                    style: TextStyle(
                        color: Colors.white,
                        //Theme.of(context).textTheme.bodySmall?.color,
                        fontSize: 10.sp,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold),
                  ),
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
        ),
      ),
    );
  }

  Future<String?> openDialog() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              'Update Count',
              style: TextStyle(fontFamily: 'Lato', fontSize: 12.sp),
            ),
            content: SizedBox(
              width: 40.w,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _textController,
                autofocus: true,
                decoration:
                    const InputDecoration(hintText: 'Enter the quantity'),
                style: TextStyle(fontFamily: 'Lato', fontSize: 10.sp),
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              TextButton(
                  onPressed: submit,
                  child: Text('Submit',
                      style: TextStyle(fontFamily: 'Lato', fontSize: 10.sp))),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel',
                      style: TextStyle(fontFamily: 'Lato', fontSize: 10.sp)))
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
    width: 8.w,
    child: TextButton(
      onPressed: press,
      child: Icon(
        icon,
        size: 12.sp,
        color: Colors.white,
      ),
    ),
  );
}
