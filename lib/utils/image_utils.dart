import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';


Widget imageAsset(
    {String? imageUrl,
    String? res,
    File? file,
    double? width,
    double? height,
    BoxFit? fit,
    String placeholder = 'image_not_found.png',
    String placeHolderError = 'image_not_found.png',
    Color? color}) {
  if (file != null) {
    return Image.file(
      file,
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }

  if (res != null) {
    if (res.contains('.svg')) {
      return SvgPicture.asset(
        'assets/images/$res',
        width: width,
        height: height,
        color: color,
      );
    }

    return Image.asset(
      'assets/images/$res',
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }

  if (imageUrl != null) {
    return CachedNetworkImage(
      placeholder: (context, url) => placeholder.contains('.json')
          ? Lottie.asset('assets/lottie/$placeholder',
              width: width, height: height)
          : placeholder.contains('.svg')
              ? SvgPicture.asset(
                  'assets/images/$placeholder',
                  width: width,
                  height: height,
                )
              : Image.asset(
                  'assets/images/$placeholder',
                  fit: fit,
                ),
      errorWidget: (context, url, error) => placeHolderError.contains('.json')
          ? Lottie.asset('assets/lottie/$placeHolderError',
              width: width, height: height)
          : placeHolderError.contains('.svg')
              ? SvgPicture.asset(
                  'assets/images/$placeHolderError',
                  width: width,
                  height: height,
                )
              : Image.asset(
                  'assets/images/$placeHolderError',
                  fit: fit,
                ),
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
    );
  }

  return imageAsset(
    placeholder: placeholder,
    placeHolderError: placeHolderError,
    imageUrl: imageUrl ?? "",
    width: width,
    height: height,
  );
}

Widget roundImageAsset({String? imageUrl, double? width, String? placeholder, String? placeHolderError}) {
  return ClipOval(
    child: Container(
      color: Colors.white,
      width: width,
      height: width,
      child: imageAsset(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: placeholder ?? '',
          placeHolderError: placeHolderError ?? placeholder ?? ""
      ),
    ),
  );
}
