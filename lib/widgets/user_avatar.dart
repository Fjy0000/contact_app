import 'package:flutter/material.dart';

import 'base_text.dart';

class UserAvatar extends StatelessWidget {
  UserAvatar({
    this.name,
    Key? key,
  }) : super(key: key);

  String? imagePath;
  String? name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
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
      child: Align(
        alignment: AlignmentDirectional.center,
        child: BaseText(getAlphabet(name ?? ''),
            color: const Color.fromRGBO(244, 238, 255, 1), fontSize: 30),
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
