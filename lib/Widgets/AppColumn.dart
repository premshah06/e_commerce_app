import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/Colors.dart';
import '../utils/Dimensions.dart';
import 'BigText.dart';
import 'IconTextWidget.dart';
import 'SmallText.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
        ),
        SizedBox(
          height: Dimensions.height5,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                ((index) {
                  return Icon(
                    Icons.star,
                    color: mainColor,
                  );
                }),
              ),
            ),
            SizedBox(
              width: Dimensions.width5,
            ),
            SmallText(text: "4.5"),
            SizedBox(
              width: Dimensions.width5,
            ),
            SmallText(text: "1287"),
            SizedBox(
              width: Dimensions.width5,
            ),
            SmallText(text: "comments"),
          ],
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconTextWidget(
                icon: Icons.currency_rupee_rounded,
                text: '20',
                size: Dimensions.font16,
                iconColor: paraColor),
            IconTextWidget(
                icon: Icons.restaurant, text: 'Shreeji', iconColor: iconColor2),
            IconTextWidget(
                icon: Icons.access_time_rounded,
                text: '32min',
                iconColor: iconColor3),
          ],
        ),
      ],
    );
  }
}
