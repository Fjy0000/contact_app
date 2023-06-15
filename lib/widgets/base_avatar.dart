import 'dart:io';
import 'package:app2/utils/image_utils.dart';
import 'package:flutter/material.dart';

class BaseAvatar extends StatelessWidget {
  BaseAvatar({
    this.height,
    this.width,
    this.imagePath,
    this.isImageUrl = false,
    this.iconPaddingAll,
    Key? key,
  }) : super(key: key);

  final bool? isImageUrl;
  final String? imagePath;
  final double? height;
  final double? width;
  final double? iconPaddingAll;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipBehavior: Clip.hardEdge,
      child: Container(
        height: height ?? 100,
        width: width ?? 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Color(0xff2575fc),
              Color(0xff6a11cb),
            ],
          ),
        ),
        child: imagePath != ''
            ? imageAsset(
                imageUrl: isImageUrl == true ? imagePath : null,
                file: isImageUrl == false ? File("$imagePath") : null,
                fit: BoxFit.cover,
              )
            : Padding(
                padding: EdgeInsets.all(iconPaddingAll ?? 25),
                child: imageAsset(
                  res: 'placeholder_avatar.svg',
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
