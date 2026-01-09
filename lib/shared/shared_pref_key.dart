import 'dart:convert';

import 'package:bhavapp/modules/login/verifyOtpModel.dart';
import 'package:bhavapp/shared/shared_pref_manager.dart';

/// Enum for all Shared Preferences keys

enum SharedPrefKey {
  isLoggedIn,
  isRegistrationDone,
  accessToken,
  userModel,
  userRole,
  dashboarAddSchoolBtnClicked,

  // Add more keys as needed
}

extension SharedPref on SharedPrefManager {
  Future<bool> isLoggedIn() async {
    return await getBool(SharedPrefKey.isLoggedIn) ?? false;
  }

  Future<void> setLoginStatus(bool status) async {
    return await saveBool(SharedPrefKey.isLoggedIn, status);
  }

  //registerd
  Future<void> setRegistrationStatus(bool status) async {
    return await saveBool(SharedPrefKey.isRegistrationDone, status);
  }

  Future<bool> isRegistrationDone() async {
    return await getBool(SharedPrefKey.isRegistrationDone) ?? false;
  }

  //token
  Future<String?> getAccessToken() async {
    return await getString(SharedPrefKey.accessToken);
  }

  Future<void> setAccessToken(String token) async {
    return await saveString(SharedPrefKey.accessToken, token);
  }

  // store whole user model as JSON
  Future<VerifyOtpModel?> getUserModel() async {
    final jsonString = await getString(SharedPrefKey.userModel);
    if (jsonString == null) return null;
    try {
      final Map<String, dynamic> map =
          jsonDecode(jsonString) as Map<String, dynamic>;
      return VerifyOtpModel.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  Future<void> setUserModel(VerifyOtpModel model) async {
    final jsonString = jsonEncode(model.toJson());
    return await saveString(SharedPrefKey.userModel, jsonString);
  }
}
