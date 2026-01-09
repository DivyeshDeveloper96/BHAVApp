// lib/modules/login/login_view.dart
import 'package:bhavapp/core/themes/colorConstants.dart';
import 'package:bhavapp/modules/login/login_controller.dart';
import 'package:bhavapp/modules/login/verifyOtp_view.dart';
import 'package:bhavapp/widgets/AppBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Enter your mobile number to log in or create an account.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Mobile Number",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Align items to the top
                  children: [
                    Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(12),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text("+91", style: TextStyle(fontSize: 16)),
                    ),
                    Expanded(
                      // 6. Replace TextField with TextFormField
                      child: TextFormField(
                        controller: _mobileController,
                        // Assign the controller
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          // Allow only numbers
                        ],
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: "Enter your mobile number",
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(12),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(12),
                            ),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(12),
                            ),
                            borderSide: BorderSide(
                              color: ColorConstant.kPrimary,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                        ),
                        // 7. Add the validator
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          if (value.length != 10) {
                            return 'Mobile number must be 10 digits';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.kPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                // 8. Call the validation method on press
                onPressed: _onContinuePressed,
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(fontSize: 12, color: Colors.black54),
                children: [
                  const TextSpan(text: "By continuing, you agree to our "),
                  TextSpan(
                    text: "Terms of Service",
                    style: TextStyle(
                      color: ColorConstant.kPrimary.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy",
                    style: TextStyle(
                      color: ColorConstant.kPrimary.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(text: "."),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _onContinuePressed() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      print("Mobile number is valid: ${_mobileController.text}");

      loginController.loginAPI("+91${_mobileController.text.trim()}").then((
        loggedin,
      ) {
        if (loggedin) {
          Get.back();
          AppBottomSheet.show(
            context,
            title: "Verify Otp",
            child: OtpVerificationView("+91${_mobileController.text.trim()}"),
          );
        }
      });
    }
  }
}
