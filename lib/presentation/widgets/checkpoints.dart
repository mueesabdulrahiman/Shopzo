import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CheckPoints extends StatelessWidget {
  CheckPoints(
      {super.key,
      this.checkTill = 1,
      required this.checkPoints,
      required this.checkPointsFillColor});

  final int checkTill;
  final List<String> checkPoints;
  final Color checkPointsFillColor;

  final double circleDia = 4.h;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double cWidth =
            (constraints.maxWidth - (32 * (checkPoints.length + 1))) /
                (checkPoints.length - 1);
        return SizedBox(
          height: 10.h,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(5.sp),
                  child: Row(
                      children: checkPoints.map((e) {
                    int index = checkPoints.indexOf(e);

                    return SizedBox(
                      height: circleDia,
                      child: Row(children: [
                        Container(
                          width: circleDia,
                          padding: EdgeInsets.all(3.sp),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index <= checkTill
                                ? checkPointsFillColor
                                : checkPointsFillColor.withOpacity(0.2),
                          ),
                          child: Icon(
                            Icons.done,
                            size: 15.sp,
                            color: Colors.white,
                          ),
                        ),
                        index != (checkPoints.length - 1)
                            ? Container(
                                width: cWidth,
                                height: 0.4.h,
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
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Lato',
                                  fontSize: 10.sp),
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
