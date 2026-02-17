// lib/modules/profile/view/profile_view.dart
import 'package:bhavapp/core/themes/colorConstants.dart';
import 'package:bhavapp/widgets/custom_app_button.dart';
import 'package:bhavapp/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../controller/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _formKey = GlobalKey<FormState>();
  final ProfileController _profileController = Get.put(ProfileController());

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _initiatedNameController = TextEditingController();

  String? _selectedGender;
  final List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final user = _profileController.user.value;
    _firstNameController.text = user.firstName ?? '';
    _lastNameController.text = user.lastName ?? '';
    _initiatedNameController.text = user.initiatedName ?? '';
    _selectedGender = user.gender;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _initiatedNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorConstant.kPrimary,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        _profileController.logout();
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              // Header Section with Profile Picture
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorConstant.kPrimary,
                      ColorConstant.kPrimary.withOpacity(0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            backgroundImage: _getProfileImage(),
                            child:
                                _getProfileImage() == null
                                    ? Icon(
                                      Icons.person,
                                      size: 60,
                                      color: ColorConstant.kPrimary,
                                    )
                                    : null,
                          ),
                        ),
                        if (_profileController.isEditMode.value)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _profileController.showImagePickerOptions,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: ColorConstant.kPrimary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _profileController.user.value.fullName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _profileController.user.value.email ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),

              // Edit/Save Toggle
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (!_profileController.isEditMode.value)
                      ElevatedButton.icon(
                        onPressed: _profileController.toggleEditMode,
                        icon: const Icon(Icons.edit, size: 18),
                        label: const Text("Edit Profile"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.kPrimary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Form Section
              Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Personal Information
                      const Text(
                        "PERSONAL INFORMATION",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // First Name & Last Name
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: "First Name",
                              hint: "First Name",
                              controller: _firstNameController,
                              readOnly: !_profileController.isEditMode.value,
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
                              label: "Last Name",
                              hint: "Last Name",
                              controller: _lastNameController,
                              readOnly: !_profileController.isEditMode.value,
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

                      // Gender
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
                          fillColor:
                              _profileController.isEditMode.value
                                  ? Colors.white
                                  : Colors.grey.shade100,
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
                        onChanged:
                            _profileController.isEditMode.value
                                ? (value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                }
                                : null,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your gender';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Initiated Name
                      CustomTextField(
                        label: "Initiated Name (Optional)",
                        hint: "Initiated Name",
                        controller: _initiatedNameController,
                        readOnly: !_profileController.isEditMode.value,
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(height: 24),

                      // Contact Information
                      const Text(
                        "CONTACT INFORMATION",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Email (Read-only)
                      CustomTextField(
                        label: "Email",
                        hint: "Email",
                        controller: TextEditingController(
                          text: _profileController.user.value.email ?? '',
                        ),
                        readOnly: true,
                      ),
                      const SizedBox(height: 20),

                      // Phone (Read-only)
                      CustomTextField(
                        label: "Mobile Number",
                        hint: "Mobile Number",
                        controller: TextEditingController(
                          text: _profileController.user.value.phone ?? '',
                        ),
                        readOnly: true,
                      ),
                      const SizedBox(height: 24),

                      // Location Details
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

                      // Country
                      _buildDropdownField(
                        label: "Country",
                        hint: "Select country",
                        value:
                            _profileController.selectedCountry.value.isEmpty
                                ? null
                                : _profileController.selectedCountry.value,
                        items: _profileController.countries,
                        onChanged: _profileController.onCountryChanged,
                        enabled: _profileController.isEditMode.value,
                      ),
                      const SizedBox(height: 20),

                      // State and City
                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdownField(
                              label: "State",
                              hint: "Select state",
                              value:
                                  _profileController.selectedState.value.isEmpty
                                      ? null
                                      : _profileController.selectedState.value,
                              items: _profileController.states,
                              onChanged: _profileController.onStateChanged,
                              enabled:
                                  _profileController.isEditMode.value &&
                                  _profileController
                                      .selectedCountry
                                      .value
                                      .isNotEmpty,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildDropdownField(
                              label: "City",
                              hint: "Select city",
                              value:
                                  _profileController.selectedCity.value.isEmpty
                                      ? null
                                      : _profileController.selectedCity.value,
                              items: _profileController.cities,
                              onChanged: _profileController.onCityChanged,
                              enabled:
                                  _profileController.isEditMode.value &&
                                  _profileController
                                      .selectedState
                                      .value
                                      .isNotEmpty,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Save/Cancel Buttons
                      if (_profileController.isEditMode.value) ...[
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: _profileController.toggleEditMode,
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.grey.shade400),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: AppButton(
                                text: "Save Changes",
                                isLoading: _profileController.isLoading.value,
                                onPressed: _onSavePressed,
                                type: AppButtonType.filled,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ],
                  ),
                ),
              ),
            ],
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
    required bool enabled,
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
        ),
      ],
    );
  }

  ImageProvider? _getProfileImage() {
    if (_profileController.profileImage.value != null) {
      return FileImage(_profileController.profileImage.value!);
    } else if (_profileController.user.value.profileImage != null) {
      return NetworkImage(_profileController.user.value.profileImage!);
    }
    return null;
  }

  void _onSavePressed() async {
    if (_formKey.currentState!.validate()) {
      final success = await _profileController.updateProfile(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        gender: _selectedGender!,
        initiatedName:
            _initiatedNameController.text.trim().isEmpty
                ? null
                : _initiatedNameController.text.trim(),
      );

      if (success) {
        _loadUserData();
      }
    }
  }
}
