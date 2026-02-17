// lib/modules/signup/controllers/signup_controller.dart
import 'dart:ui';

import 'package:bhavapp/core/network/Base/BaseController.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';

import '../../../utils/location_data.dart';
import '../../login/model/user_model.dart';

class SignupController extends BaseController {
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxString passwordStrength = ''.obs;
  final RxBool termsAccepted = false.obs;

  // Location data
  final RxList<String> countries = <String>[].obs;
  final RxList<String> states = <String>[].obs;
  final RxList<String> cities = <String>[].obs;

  final RxString selectedCountry = ''.obs;
  final RxString selectedState = ''.obs;
  final RxString selectedCity = ''.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void onInit() {
    super.onInit();
    _loadCountries();
  }

  void _loadCountries() {
    countries.value = LocationData.getCountries();
  }

  void onCountryChanged(String? country) {
    if (country != null && country.isNotEmpty) {
      selectedCountry.value = country;
      states.value = LocationData.getStates(country);
      selectedState.value = '';
      selectedCity.value = '';
      cities.clear();
    }
  }

  void onStateChanged(String? state) {
    if (state != null && state.isNotEmpty) {
      selectedState.value = state;
      cities.value = LocationData.getCities(selectedCountry.value, state);
      selectedCity.value = '';
    }
  }

  void onCityChanged(String? city) {
    if (city != null && city.isNotEmpty) {
      selectedCity.value = city;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void toggleTerms() {
    termsAccepted.value = !termsAccepted.value;
  }

  void checkPasswordStrength(String password) {
    if (password.isEmpty) {
      passwordStrength.value = '';
      return;
    }

    int strength = 0;

    // Length check
    if (password.length >= 8) strength++;
    if (password.length >= 12) strength++;

    // Uppercase check
    if (password.contains(RegExp(r'[A-Z]'))) strength++;

    // Lowercase check
    if (password.contains(RegExp(r'[a-z]'))) strength++;

    // Number check
    if (password.contains(RegExp(r'[0-9]'))) strength++;

    // Special character check
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;

    if (strength <= 2) {
      passwordStrength.value = 'Weak';
    } else if (strength <= 4) {
      passwordStrength.value = 'Medium';
    } else {
      passwordStrength.value = 'Strong';
    }
  }

  Color getPasswordStrengthColor() {
    switch (passwordStrength.value) {
      case 'Weak':
        return const Color(0xFFE57373);
      case 'Medium':
        return const Color(0xFFFFB74D);
      case 'Strong':
        return const Color(0xFF66BB6A);
      default:
        return const Color(0xFFE0E0E0);
    }
  }

  double getPasswordStrengthProgress() {
    switch (passwordStrength.value) {
      case 'Weak':
        return 0.33;
      case 'Medium':
        return 0.66;
      case 'Strong':
        return 1.0;
      default:
        return 0.0;
    }
  }

  // Signup with Email/Password
  Future<bool> signupWithEmail({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String gender,
    String? initiatedName,
  }) async {
    try {
      isLoading.value = true;

      // Create Firebase user
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password,
          );

      if (credential.user != null) {
        // Update display name
        await credential.user!.updateDisplayName('$firstName $lastName');

        // Create user model
        final user = UserModel(
          id: credential.user!.uid,
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          gender: gender,
          initiatedName: initiatedName,
          country: selectedCountry.value,
          state: selectedState.value,
          city: selectedCity.value,
        );

        // Sync with your backend
        // await _syncUserWithBackend(user);

        isLoading.value = false;
        Get.snackbar(
          'Success',
          'Account created successfully!',
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      }

      isLoading.value = false;
      return false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String message = 'Signup failed';

      switch (e.code) {
        case 'email-already-in-use':
          message = 'This email is already registered';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        case 'weak-password':
          message = 'Password is too weak';
          break;
        default:
          message = e.message ?? 'Signup failed';
      }

      Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
      return false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'An error occurred during signup',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  // Google Sign Up
  Future<bool> googleSignUp() async {
    try {
      isLoading.value = true;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        isLoading.value = false;
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      if (userCredential.user != null) {
        final user = UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email,
          firstName: userCredential.user!.displayName?.split(' ').first,
          lastName: userCredential.user!.displayName?.split(' ').last,
          profileImage: userCredential.user!.photoURL,
        );

        // Sync with backend
        // await _syncUserWithBackend(user);

        isLoading.value = false;
        return true;
      }

      isLoading.value = false;
      return false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Google Sign Up failed',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  /*// Apple Sign Up (iOS only)
  Future<bool> appleSignUp() async {
    if (!Platform.isIOS) {
      Get.snackbar(
        'Error',
        'Apple Sign In is only available on iOS',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    try {
      isLoading.value = true;

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        oauthCredential,
      );

      if (userCredential.user != null) {
        final user = UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email ?? appleCredential.email,
          firstName: appleCredential.givenName,
          lastName: appleCredential.familyName,
        );

        // Sync with backend
        // await _syncUserWithBackend(user);

        isLoading.value = false;
        return true;
      }

      isLoading.value = false;
      return false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Apple Sign Up failed',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }*/

  // Validate password strength
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter a password';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }
}
