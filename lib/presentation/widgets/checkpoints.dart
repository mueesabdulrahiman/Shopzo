import 'package:flutter/material.dart';

class CheckPoints extends StatelessWidget {
  const CheckPoints(
      {super.key,
      this.checkTill = 1,
      required this.checkPoints,
      required this.checkPointsFillColor});

  final int checkTill;
  final List<String> checkPoints;
  final Color checkPointsFillColor;

  final double circleDia = 32;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double cWidth =
            (constraints.maxWidth - (32 * (checkPoints.length + 1))) /
                (checkPoints.length - 1);
        return SizedBox(
          height: 65,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(7.0),
                  child: Row(
                      children: checkPoints.map((e) {
                    int index = checkPoints.indexOf(e);
                    print(e.toString());

                    return SizedBox(
                      height: circleDia,
                      child: Row(children: [
                        Container(
                          width: circleDia,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index <= checkTill
                                ? checkPointsFillColor
                                : checkPointsFillColor.withOpacity(0.2),
                          ),
                          child: const Icon(
                            Icons.done,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                        index != (checkPoints.length - 1)
                            ? Container(
                                width: cWidth,
                                height: 4,
                                color: index < checkTill
                                    ? checkPointsFillColor
                                    : checkPointsFillColor.withOpacity(0.2),
                              )
                            : Container(),
                      ]),
                    );
                  }).toList()),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: checkPoints
                        .map((e) => Text(
                              e,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ))
                        .toList(),
                  ),
                ),
              ]),
        );
      },
    );
  }
}
