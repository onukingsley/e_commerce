import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color? color;
  double size;
  TextOverflow overflow;

  BigText(
      {super.key,
      required this.text,
      this.color = const Color(0xFF332d2b),
      this.overflow = TextOverflow.ellipsis,
      this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: overflow,
        style: TextStyle(
            color: color, fontWeight: FontWeight.w400, fontFamily: 'Roboto'));
  }
}
