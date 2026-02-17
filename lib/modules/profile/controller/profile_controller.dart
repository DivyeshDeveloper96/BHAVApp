// lib/modules/profile/controllers/profile_controller.dart
import 'package:bhavapp/core/network/Base/BaseController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import '../../../utils/location_data.dart';
import '../../login/model/user_model.dart';

class ProfileController extends BaseController {
  final RxBool isLoading = false.obs;
  final RxBool isEditMode = false.obs;
  final Rx<UserModel> user = UserModel().obs;
  final Rx<File?> profileImage = Rx<File?>(null);
  
  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Location data
  final RxList<String> countries = <String>[].obs;
  final RxList<String> states = <String>[].obs;
  final RxList<String> cities = <String>[].obs;

  final RxString selectedCountry = ''.obs;
  final RxString selectedState = ''.obs;
  final RxString selectedCity = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCountries();
    _loadUserData();
  }

  void _loadCountries() {
    countries.value = LocationData.getCountries();
  }

  void _loadUserData() {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      user.value = UserModel(
        id: currentUser.uid,
        email: currentUser.email,
        firstName: currentUser.displayName?.split(' ').first,
        lastName: currentUser.displayName?.split(' ').last,
        profileImage: currentUser.photoURL,
        phone: currentUser.phoneNumber,
      );

      // Load location data if available
      if (user.value.country != null) {
        selectedCountry.value = user.value.country!;
        _loadStates(user.value.country!);
        
        if (user.value.state != null) {
          selectedState.value = user.value.state!;
          _loadCities(user.value.country!, user.value.state!);
          
          if (user.value.city != null) {
            selectedCity.value = user.value.city!;
          }
        }
      }
    }
  }

  void _loadStates(String country) {
    states.value = LocationData.getStates(country);
  }

  void _loadCities(String country, String state) {
    cities.value = LocationData.getCities(country, state);
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

  void toggleEditMode() {
    isEditMode.value = !isEditMode.value;
    if (!isEditMode.value) {
      // Reset to original data if cancelled
      _loadUserData();
      profileImage.value = null;
    }
  }

  // Pick image from gallery
  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        profileImage.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image from gallery',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Pick image from camera
  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        profileImage.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to capture image',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Show image picker options
  void showImagePickerOptions() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.blue),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Get.back();
                pickImageFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.green),
              title: const Text('Take a Photo'),
              onTap: () {
                Get.back();
                pickImageFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.close, color: Colors.red),
              title: const Text('Cancel'),
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }

  // Update profile
  Future<bool> updateProfile({
    required String firstName,
    required String lastName,
    required String gender,
    String? initiatedName,
  }) async {
    try {
      isLoading.value = true;

      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        isLoading.value = false;
        return false;
      }

      // Update display name in Firebase
      await currentUser.updateDisplayName('$firstName $lastName');

      // Upload profile image if changed
      String? imageUrl;
      if (profileImage.value != null) {
        // Here you would upload the image to Firebase Storage
        // imageUrl = await uploadImageToStorage(profileImage.value!);
        // For now, we'll use a placeholder
      }

      // Update user model
      user.value = UserModel(
        id: currentUser.uid,
        firstName: firstName,
        lastName: lastName,
        email: user.value.email,
        phone: user.value.phone,
        gender: gender,
        initiatedName: initiatedName,
        country: selectedCountry.value,
        state: selectedState.value,
        city: selectedCity.value,
        profileImage: imageUrl ?? user.value.profileImage,
      );

      // Sync with your backend
      // await _syncUserWithBackend(user.value);

      isLoading.value = false;
      isEditMode.value = false;
      profileImage.value = null;

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to update profile',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
      user.value = UserModel();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Logout failed',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
