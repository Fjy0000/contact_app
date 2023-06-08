import 'package:app2/utils/image_utils.dart';
import 'package:flutter/material.dart';

import 'base_text.dart';

class UserAvatar extends StatelessWidget {
  UserAvatar({
    this.name,
    this.height,
    this.width,
    this.imagePath,
    this.color,
    this.fontSize,
    Key? key,
  }) : super(key: key);

  String? imagePath;
  String? name;
  double? height;
  double? width;
  double? fontSize;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(0, 74, 173, 1),
            Color.fromRGBO(26, 49, 131, 1),
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: imagePath != null
            ? imageAsset(res: imagePath)
            : BaseText(getAlphabet(name ?? ''),
                color: color ?? Colors.white, fontSize: fontSize),
      ),
    );
  }

  String getAlphabet(String name) {
    if (name.isEmpty) {
      return "-";
    }
    return name[0].toUpperCase();
  }
}
