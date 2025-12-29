import 'dart:ui';
import 'package:bhavapp/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialog extends StatefulWidget {
  final GestureTapCallback btnPosClick;
  final GestureTapCallback btnNegClick;
  final String title;
  final String message;
  final String btnPositiveText;
  final String btnNegativeText;
  final bool isSingleButton;
  final Widget? messageWidget;
  final Color? bgColor;
  final bool? showCloseBtn;
  final bool showIcon;

  const CustomAlertDialog({
    super.key,
    required this.btnPosClick,
    required this.btnNegClick,
    required this.title,
    required this.message,
    required this.btnPositiveText,
    required this.btnNegativeText,
    required this.isSingleButton,
    this.messageWidget,
    this.bgColor,
    this.showIcon = false,
    this.showCloseBtn = true,
  });

  static void show({
    required GestureTapCallback btnPosClick,
    required GestureTapCallback btnNegClick,
    required String title,
    required String message,
    required String btnPositiveText,
    required String btnNegativeText,
    bool isSingleButton = false,
    Widget? messageWidget,
    Color? bgColor,
    bool showIcon = false,
  }) {
    Get.dialog(
      CustomAlertDialog(
        btnPosClick: btnPosClick,
        btnNegClick: btnNegClick,
        title: title,
        message: message,
        btnPositiveText: btnPositiveText,
        btnNegativeText: btnNegativeText,
        isSingleButton: isSingleButton,
        messageWidget: messageWidget,
        bgColor: bgColor,
        showIcon: showIcon,
      ),
      barrierDismissible: true,
    );
  }

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(color: Colors.black.withAlpha(40)),
        ),
        Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.bgColor ?? Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.showCloseBtn == true)
                    Align(
                      alignment: Alignment.topRight,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.close,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  if (widget.showIcon)
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Icon(
                        Icons.warning,
                        size: 48,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      //fontFamily: poppins,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  widget.messageWidget ??
                      Text(
                        widget.message,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(/*fontFamily: poppins*/),
                        textAlign: TextAlign.center,
                      ),
                  const SizedBox(height: 20),
                  widget.isSingleButton
                      ? CustomButton(
                        buttonType: ButtonType.filled,
                        title: widget.btnPositiveText,
                        onTap: widget.btnPosClick,
                      )
                      : Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              buttonType: ButtonType.border,
                              title: widget.btnNegativeText,
                              onTap: widget.btnNegClick,
                              borderColor: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomButton(
                              buttonType: ButtonType.filled,
                              title: widget.btnPositiveText,
                              onTap: widget.btnPosClick,
                            ),
                          ),
                        ],
                      ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
