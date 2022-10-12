import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SmallText extends StatelessWidget {
  final String text;
  final Color? color;
  double size;
  TextOverflow overflow;
  double height;

  SmallText(
      {super.key,
      required this.text,
      this.color = const Color(0xFFccc7c5),
      this.overflow = TextOverflow.ellipsis,
      this.height = 1.2,
      this.size = 12});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: 1,
        overflow: overflow,
        style: TextStyle(color: color, fontSize: size, fontFamily: 'Roboto'));
  }
}
