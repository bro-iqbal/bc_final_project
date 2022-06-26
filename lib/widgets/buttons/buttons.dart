import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    Key? key,
    this.radius,
    required this.backgroundColor,
    required this.child,
    required this.borderColor,
    required this.handler,
  }) : super(key: key);

  final double? radius;
  final Color backgroundColor;
  final Widget child;
  final Color borderColor;
  final Function()? handler;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 12,
      ),
      child: ElevatedButton(
        child: child,
        onPressed: handler,
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 25),
            side: BorderSide(
              color: borderColor,
            ),
          ),
          fixedSize: Size(
            MediaQuery.of(context).size.width * 0.8,
            50,
          ),
        ),
      ),
    );
  }
}
