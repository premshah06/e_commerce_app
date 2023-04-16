import 'package:e_commerce_app/Widgets/SmallText.dart';
import 'package:e_commerce_app/utils/Dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class IconTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  double size;
  IconTextWidget(
      {Key? key,
      this.size = 0,
      required this.icon,
      required this.text,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconSize24,
        ),
        SizedBox(width: 5),
        SmallText(
          text: text,
          size: size == 0 ? Dimensions.font12 : size,
        )
      ],
    );
  }
}
