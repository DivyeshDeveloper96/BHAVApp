// lib/modules/signup/view/signup_view.dart
import 'package:bhavapp/core/themes/colorConstants.dart';
import 'package:bhavapp/widgets/custom_app_button.dart';
import 'package:bhavapp/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../controller/signup_controller.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final SignupController _signupController = Get.put(SignupController());

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _initiatedNameController = TextEditingController();

  String? _selectedGender;
  final List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _initiatedNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Create Account",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Text(
                  "Join our Community",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Begin your spiritual journey with us today",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
                const SizedBox(height: 32),

                // Legal Name Row
                const Text(
                  "Legal Name",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hint: "First Name",
                        controller: _firstNameController,
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomTextField(
                        hint: "Last Name",
                        controller: _lastNameController,
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Gender Dropdown
                const Text(
                  "Gender",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: InputDecoration(
                    hintText: "Select gender",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: ColorConstant.kPrimary,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  items:
                      _genders.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Initiated Name (Optional)
                CustomTextField(
                  label: "Initiated Name (Optional)",
                  hint: "Enter your initiated name",
                  controller: _initiatedNameController,
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 20),

                // Email
                CustomTextField(
                  label: "Email ID",
                  hint: "Enter your email address",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Mobile Number with Country Code
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
                  children: [
                    Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(14),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text("+91", style: TextStyle(fontSize: 16)),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: "98765-43210",
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(14),
                            ),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(14),
                            ),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(14),
                            ),
                            borderSide: BorderSide(
                              color: ColorConstant.kPrimary,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(14),
                            ),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1.5,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          if (value.length != 10) {
                            return 'Must be 10 digits';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Password
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: "Password",
                        hint: "Create a strong password",
                        controller: _passwordController,
                        obscureText: !_signupController.isPasswordVisible.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _signupController.isPasswordVisible.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: _signupController.togglePasswordVisibility,
                        ),
                        onChanged: (value) {
                          _signupController.checkPasswordStrength(value);
                        },
                        validator: _signupController.validatePassword,
                      ),
                      if (_signupController
                          .passwordStrength
                          .value
                          .isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value:
                                    _signupController
                                        .getPasswordStrengthProgress(),
                                backgroundColor: Colors.grey.shade200,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  _signupController.getPasswordStrengthColor(),
                                ),
                                minHeight: 4,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              _signupController.passwordStrength.value,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color:
                                    _signupController
                                        .getPasswordStrengthColor(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Confirm Password
                Obx(
                  () => CustomTextField(
                    label: "Confirm Password",
                    hint: "Re-enter your password",
                    controller: _confirmPasswordController,
                    obscureText:
                        !_signupController.isConfirmPasswordVisible.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _signupController.isConfirmPasswordVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      ),
                      onPressed:
                          _signupController.toggleConfirmPasswordVisibility,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Location Section
                const Text(
                  "LOCATION DETAILS",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 16),

                // Country Dropdown
                Obx(
                  () => _buildDropdownField(
                    label: "Country",
                    hint: "Select country",
                    value:
                        _signupController.selectedCountry.value.isEmpty
                            ? null
                            : _signupController.selectedCountry.value,
                    items: _signupController.countries,
                    onChanged: _signupController.onCountryChanged,
                  ),
                ),
                const SizedBox(height: 20),

                // State and City Row
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => _buildDropdownField(
                          label: "State",
                          hint: "Select state",
                          value:
                              _signupController.selectedState.value.isEmpty
                                  ? null
                                  : _signupController.selectedState.value,
                          items: _signupController.states,
                          onChanged: _signupController.onStateChanged,
                          enabled:
                              _signupController
                                  .selectedCountry
                                  .value
                                  .isNotEmpty,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Obx(
                        () => _buildDropdownField(
                          label: "City",
                          hint: "Select city",
                          value:
                              _signupController.selectedCity.value.isEmpty
                                  ? null
                                  : _signupController.selectedCity.value,
                          items: _signupController.cities,
                          onChanged: _signupController.onCityChanged,
                          enabled:
                              _signupController.selectedState.value.isNotEmpty,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Terms and Conditions
                Obx(
                  () => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _signupController.termsAccepted.value,
                        onChanged: (value) {
                          _signupController.toggleTerms();
                        },
                        activeColor: ColorConstant.kPrimary,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                              children: [
                                const TextSpan(text: "I agree to the "),
                                TextSpan(
                                  text: "Terms & Conditions",
                                  style: TextStyle(
                                    color: ColorConstant.kPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const TextSpan(text: " and "),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                    color: ColorConstant.kPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Create Account Button
                Obx(
                  () => AppButton(
                    type: AppButtonType.filled,
                    text: "Create Account",
                    isLoading: _signupController.isLoading.value,
                    onPressed: _onSignupPressed,
                  ),
                ),
                const SizedBox(height: 24),

                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "OR SIGN UP WITH",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),
                const SizedBox(height: 24),

                // Social Sign Up Buttons
                Row(
                  children: [
                    Expanded(
                      child: _SocialIconButton(
                        icon: Icons.g_mobiledata_outlined,
                        label: "Google",
                        onPressed: () async {
                          final success =
                              await _signupController.googleSignUp();
                          if (success) {
                            Get.offAllNamed('/profile');
                          }
                        },
                      ),
                    ),
                    if (Platform.isIOS) ...[
                      const SizedBox(width: 16),
                      Expanded(
                        child: _SocialIconButton(
                          icon: Icons.apple,
                          label: "Apple",
                          onPressed: () async {
                            /*final success =
                                await _signupController.appleSignUp();
                            if (success) {
                              Get.offAllNamed('/profile');
                            }*/
                          },
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 24),

                // Already have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.black54),
                    ),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: ColorConstant.kPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300),
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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          items:
              items.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
          onChanged: enabled ? onChanged : null,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select $label';
            }
            return null;
          },
        ),
      ],
    );
  }

  void _onSignupPressed() async {
    if (!_signupController.termsAccepted.value) {
      Get.snackbar(
        'Error',
        'Please accept Terms & Conditions',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      final success = await _signupController.signupWithEmail(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        phone: "+91${_phoneController.text.trim()}",
        gender: _selectedGender!,
        initiatedName:
            _initiatedNameController.text.trim().isEmpty
                ? null
                : _initiatedNameController.text.trim(),
      );

      if (success) {
        Get.offAllNamed('/profile');
      }
    }
  }
}

class _SocialIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _SocialIconButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: Colors.black87),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
