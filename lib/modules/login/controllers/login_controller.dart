import 'package:bhavapp/core/network/Base/BaseController.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';

import '../model/user_model.dart';

class LoginController extends BaseController {
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final Rx<UserModel> user = UserModel().obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void onInit() {
    super.onInit();
    _checkCurrentUser();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void _checkCurrentUser() {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      user.value = UserModel(
        id: currentUser.uid,
        email: currentUser.email,
        firstName: currentUser.displayName?.split(' ').first,
        lastName: currentUser.displayName?.split(' ').last,
        profileImage: currentUser.photoURL,
      );
    }
  }

  // Email/Password Login
  Future<bool> loginWithEmail(String email, String password) async {
    try {
      isLoading.value = true;
      
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (credential.user != null) {
        user.value = UserModel(
          id: credential.user!.uid,
          email: credential.user!.email,
          firstName: credential.user!.displayName?.split(' ').first,
          lastName: credential.user!.displayName?.split(' ').last,
          profileImage: credential.user!.photoURL,
        );

        // Call your API to sync user data
        // await _syncUserWithBackend(user.value);

        isLoading.value = false;
        return true;
      }

      isLoading.value = false;
      return false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String message = 'Login failed';
      
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found with this email';
          break;
        case 'wrong-password':
          message = 'Incorrect password';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        case 'user-disabled':
          message = 'This account has been disabled';
          break;
        default:
          message = e.message ?? 'Login failed';
      }
      
      Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
      return false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An error occurred during login',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  // Google Sign In
  Future<bool> googleSignIn() async {
    try {
      isLoading.value = true;

      // Trigger the Google Sign In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        isLoading.value = false;
        return false; // User cancelled
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        user.value = UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email,
          firstName: userCredential.user!.displayName?.split(' ').first,
          lastName: userCredential.user!.displayName?.split(' ').last,
          profileImage: userCredential.user!.photoURL,
        );

        // Call your API to sync user data
        // await _syncUserWithBackend(user.value);

        isLoading.value = false;
        return true;
      }

      isLoading.value = false;
      return false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Google Sign In failed: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  /*// Apple Sign In (iOS only)
  Future<bool> appleSignIn() async {
    if (!Platform.isIOS) {
      Get.snackbar('Error', 'Apple Sign In is only available on iOS',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    try {
      isLoading.value = true;

     *//* final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );*//*

    *//*  final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );*//*

      final UserCredential userCredential =
          await _auth.signInWithCredential(oauthCredential);

      if (userCredential.user != null) {
        user.value = UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email ?? appleCredential.email,
          firstName: appleCredential.givenName,
          lastName: appleCredential.familyName,
        );

        // Call your API to sync user data
        // await _syncUserWithBackend(user.value);

        isLoading.value = false;
        return true;
      }

      isLoading.value = false;
      return false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Apple Sign In failed: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }*/

  // Logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      user.value = UserModel();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', 'Logout failed',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Password Reset
  Future<bool> resetPassword(String email) async {
    try {
      isLoading.value = true;
      await _auth.sendPasswordResetEmail(email: email.trim());
      isLoading.value = false;
      Get.snackbar(
        'Success',
        'Password reset email sent. Please check your inbox.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String message = 'Failed to send reset email';
      
      if (e.code == 'user-not-found') {
        message = 'No user found with this email';
      }
      
      Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
      return false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An error occurred',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  // Sync with your backend API (implement according to your API)
  // Future<void> _syncUserWithBackend(UserModel user) async {
  //   var body = {
  //     "uid": user.id,
  //     "email": user.email,
  //     "firstName": user.firstName,
  //     "lastName": user.lastName,
  //   };
  //   // Call your backend API
  //   // await CommonController().syncUser(body);
  // }
}
