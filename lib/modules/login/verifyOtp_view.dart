import 'package:bhavapp/core/themes/colorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key});

  static const Color kPrimary = Color(0xFF6B21A8);
  static const Color kBgLight = Color(0xFFF3E8FF);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                (index) => _OtpBox(isFirst: index == 0, isLast: index == 5),
              ),
            ),

            const SizedBox(height: 24),

            /// RESEND
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.black54),
                children: [
                  TextSpan(text: "Didn't receive the code? "),
                  TextSpan(text: "Resend code in "),
                  TextSpan(
                    text: "00:59",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kPrimary,
                    ),
                  ),
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
                backgroundColor: kPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                // TODO: Verify OTP API call
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
    );
  }
}

/// SINGLE OTP BOX
class _OtpBox extends StatelessWidget {
  final bool isFirst;
  final bool isLast;

  const _OtpBox({required this.isFirst, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: TextField(
        autofocus: isFirst,
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.purple.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: ColorConstant.kPrimary, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && !isLast) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && !isFirst) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
