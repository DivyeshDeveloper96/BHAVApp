import 'dart:async'; // 1. Import the async library for the Timer

import 'package:bhavapp/core/themes/colorConstants.dart';
import 'package:bhavapp/modules/login/verifyOtp_controller.dart';
import 'package:bhavapp/routes/page_identifier.dart';
import 'package:bhavapp/utils/utilsCommon.dart';
import 'package:flutter/gestures.dart'; // Import for TapGestureRecognizer
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OtpVerificationView extends StatefulWidget {
  final String phone;

  const OtpVerificationView(this.phone, {super.key});

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  final _formKey = GlobalKey<FormState>();
  VerifyOtpController verifyOtpController = Get.put(VerifyOtpController());
  late final List<TextEditingController> _otpControllers;
  late final List<FocusNode> _otpFocusNodes;
  String _otp = "";

  // 2. Add state variables for the timer
  late Timer _timer;
  int _countdown = 60;
  bool _isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(6, (_) => TextEditingController());
    _otpFocusNodes = List.generate(6, (_) => FocusNode());
    startTimer(); // 3. Start the timer when the widget is initialized
  }

  // 4. Create the timer logic
  void startTimer() {
    _isResendEnabled = false; // Disable resend button when timer starts
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown == 0) {
        setState(() {
          timer.cancel(); // Stop the timer
          _isResendEnabled = true; // Enable the resend button
        });
      } else {
        setState(() {
          _countdown--; // Decrement the countdown
        });
      }
    });
  }

  // 5. Create a function to handle resending OTP
  void _resendOtp() {
    if (_isResendEnabled) {
      setState(() {
        _countdown = 60; // Reset the countdown
        _isResendEnabled = false; // Disable the button again
        startTimer(); // Restart the timer
      });
      // TODO: Add your actual logic to call the resend OTP API here
      print("Resending OTP...");
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // 6. IMPORTANT: Cancel the timer to prevent memory leaks
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onVerifyPressed() {}

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// BODY
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              const Text(
                "Enter the 6-digit code sent to +91 98******89",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
              const SizedBox(height: 32),

              /// OTP BOXES
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  6,
                  (index) => _OtpBox(
                    controller: _otpControllers[index],
                    focusNode: _otpFocusNodes[index],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ' '; // Return a non-empty string for error
                      }
                      return null;
                    },
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// RESEND
              // 7. Use conditional logic for the resend text
              _isResendEnabled
                  ? RichText(
                    text: TextSpan(
                      text: "Resend OTP",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.kPrimary,
                        decoration: TextDecoration.underline,
                      ),
                      // Make the text clickable
                      recognizer: TapGestureRecognizer()..onTap = _resendOtp,
                    ),
                  )
                  : RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      children: [
                        const TextSpan(
                          text: "Didn't receive the code? Resend in ",
                        ),
                        TextSpan(
                          // Format the countdown to always show two digits (e.g., 09, 08)
                          text: _countdown.toString().padLeft(2, '0'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.kPrimary,
                          ),
                        ),
                        const TextSpan(text: "s"),
                      ],
                    ),
                  ),
            ],
          ),

          /// VERIFY BUTTON
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.kPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    // If valid, combine the OTP from all controllers
                    _otp =
                        _otpControllers
                            .map((controller) => controller.text)
                            .join();
                    print("Form is valid. OTP entered: $_otp");
                    verifyOtpController.verifyOtpAPI(widget.phone, _otp).then((
                      verified,
                    ) {
                      if (verified) {
                        Get.back();
                        UtilsCommon.showCustomSnackBar(
                          context,
                          isSuccess: true,
                          message: "OTP verified successfully",
                        );
                        Get.to(PageIdentifier.registraionDeatils.name);
                      } else {
                        UtilsCommon.showCustomSnackBar(
                          context,
                          isSuccess: false,
                          message: "Invalid OTP",
                        );
                      }
                    });
                  } else {
                    print("Form is invalid. Please enter all 6 digits.");
                  }
                },
                child: const Text(
                  "Verify & Proceed",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// SINGLE OTP BOX WIDGET
class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FormFieldValidator<String>? validator;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 4), // Reduced margin
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: focusNode.hasFocus,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorConstant.kPrimary,
        ),
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          errorStyle: const TextStyle(height: 0.01, color: Colors.transparent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.purple.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: ColorConstant.kPrimary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
        validator: validator,
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          } else {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
