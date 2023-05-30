import 'package:app2/utils/image_utils.dart';
import 'package:flutter/material.dart';
import '../utils/constants/constant.dart';

class BaseScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;

  // final String background;
  final Color? backgroundColor;
  final Widget? floatingActionButton;

  // this.background = "background.png"
  BaseScaffold(
      {this.appBar,
      required this.body,
      this.floatingActionButton,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: imageAsset(
            res: "background.png",
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Scaffold(
              backgroundColor: backgroundColor ?? Colors.transparent,
              // extendBodyBehindAppBar: true,
              appBar: appBar,
              floatingActionButton: floatingActionButton,
              body: body),
        ),
      ],
    );
  }
}
