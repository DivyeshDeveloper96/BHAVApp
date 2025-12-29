import 'package:bhavapp/core/themes/colorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ButtonType { filled, border, text, acceptFilled }

class CustomButton extends StatelessWidget {
  final ButtonType buttonType;
  final VoidCallback onTap;
  final String title;
  final TextStyle? textStyle;
  final bool isEnable;

  Color? borderColor = Theme.of(Get.context!).primaryColor;
  final bool underlineText;

  CustomButton({
    super.key,
    required this.buttonType,
    required this.onTap,
    required this.title,
    this.textStyle,
    this.isEnable = true,
    this.borderColor,
    this.underlineText = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = textStyle ?? Theme.of(context).textTheme.headlineSmall;

    switch (buttonType) {
      case ButtonType.filled:
        return Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isEnable ? onTap : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              disabledBackgroundColor: Theme.of(
                context,
              ).primaryColor.withAlpha(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
            ),
          ),
        );
      case ButtonType.acceptFilled:
        return Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isEnable ? onTap : null,
            style: ElevatedButton.styleFrom(
              //backgroundColor: ColorConstant.successGreen,
              disabledBackgroundColor: Theme.of(
                context,
              ).primaryColor.withAlpha(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
            ),
          ),
        );
      case ButtonType.border:
        return Container(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: isEnable ? onTap : null,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                  color: isEnable
                      ? borderColor ?? Theme.of(context).primaryColor
                      : Colors.grey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            child: Text(
              title,
              style: (textStyle ??
                  Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).primaryColor)),
            ),
          ),
        );

      case ButtonType.text:
        return TextButton(
          onPressed: isEnable ? onTap : null,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            // removes inner padding
            minimumSize: Size(0, 0),
            // removes minimum size constraint
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // removes extra touch padding
            visualDensity:
                VisualDensity.compact, // reduces vertical/horizontal space
          ),
          child: Text(
            title,
            style: style?.copyWith(
                color: isEnable ? Theme.of(context).primaryColor : Colors.grey,
                decoration: underlineText
                    ? TextDecoration.underline
                    : TextDecoration.none,
                decorationColor: borderColor ?? Theme.of(context).primaryColor,
                decorationStyle: TextDecorationStyle.solid),
          ),
        );
    }
  }
}
