import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/themes/colorConstants.dart';

enum AppButtonType { filled, border, text, success }

class AppButton extends StatelessWidget {
  final AppButtonType type;
  final String text;
  final VoidCallback? onPressed;

  final bool isLoading;
  final bool isDisabled;
  final bool underlineText;
  final bool useGradient;

  final double height;
  final double? width;
  final double borderRadius;

  final TextStyle? textStyle;
  final Color? borderColor;
  final EdgeInsetsGeometry padding;

  const AppButton({
    super.key,
    required this.type,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.underlineText = false,
    this.useGradient = true,
    this.height = 52,
    this.width,
    this.borderRadius = 14,
    this.textStyle,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  bool get _isEnabled => !isDisabled && !isLoading && onPressed != null;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AppButtonType.filled:
      case AppButtonType.success:
        return _buildFilled(context);

      case AppButtonType.border:
        return _buildBorder(context);

      case AppButtonType.text:
        return _buildText(context);
    }
  }

  // ================= FILLED BUTTON =================

  Widget _buildFilled(BuildContext context) {
    final Color baseColor =
        type == AppButtonType.success ? Colors.green : ColorConstant.kPrimary;

    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        gradient:
            _isEnabled && useGradient
                ? LinearGradient(
                  colors: [baseColor, baseColor.withOpacity(0.85)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                : null,
        color:
            !_isEnabled
                ? Colors.grey.shade300
                : !useGradient
                ? baseColor
                : null,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow:
            _isEnabled
                ? [
                  BoxShadow(
                    color: baseColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
                : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: _isEnabled ? onPressed : null,
          child: Padding(
            padding: padding,
            child: Center(
              child:
                  isLoading
                      ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                      : Text(
                        text,
                        style:
                            textStyle ??
                            TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  _isEnabled
                                      ? Colors.white
                                      : Colors.grey.shade600,
                            ),
                      ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= BORDER BUTTON =================

  Widget _buildBorder(BuildContext context) {
    final Color color = borderColor ?? Theme.of(context).primaryColor;

    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: OutlinedButton(
        onPressed: _isEnabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: _isEnabled ? color : Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child:
            isLoading
                ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: color,
                  ),
                )
                : Text(
                  text,
                  style:
                      textStyle ??
                      TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _isEnabled ? color : Colors.grey,
                      ),
                ),
      ),
    );
  }

  // ================= TEXT BUTTON =================

  Widget _buildText(BuildContext context) {
    final Color color = borderColor ?? Theme.of(context).primaryColor;

    return TextButton(
      onPressed: _isEnabled ? onPressed : null,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      child: Text(
        text,
        style:
            textStyle ??
            TextStyle(
              fontSize: 15,
              color: _isEnabled ? color : Colors.grey,
              decoration: underlineText ? TextDecoration.underline : null,
            ),
      ),
    );
  }
}
