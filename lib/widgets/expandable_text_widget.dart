import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({super.key, required this.text});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondhalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondhalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondhalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondhalf.isEmpty
            ? SmallText(
                height: Dimensions.lineheight,
                color: AppColors.paraColor,
                size: Dimensions.font16,
                text: firstHalf)
            : Column(
                children: [
                  SmallText(
                      height: Dimensions.lineheight,
                      color: AppColors.paraColor,
                      size: Dimensions.font16,
                      text: hiddenText
                          ? (firstHalf + '...')
                          : (firstHalf + secondhalf)),
                  InkWell(
                    onTap: () {
                      setState(() {
                        hiddenText = !hiddenText;
                      });
                    },
                    child: Row(children: [
                      SmallText(
                        text: hiddenText ? "show more" : "show less",
                        color: AppColors.mainColor,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                      )
                    ]),
                  )
                ],
              ));
  }
}
