
import 'package:bhavapp/shared/shared_pref_manager.dart';

/// Enum for all Shared Preferences keys

enum SharedPrefKey {
  isLoggedIn,
  isRegistrationDone,
  accessToken,
  userModel,
  userRole,
  dashboarAddSchoolBtnClicked

  // Add more keys as needed
}

extension SharedPref on SharedPrefManager {
  Future<bool> isLoggedIn() async {
    return await getBool(SharedPrefKey.isLoggedIn) ?? false;
  }

  Future<void> setLoginStatus(bool status) async {
    return await saveBool(SharedPrefKey.isLoggedIn, status);
  }

  Future<void> setDashboardAddSchooleClickedStatus(bool status) async {
    return await saveBool(SharedPrefKey.dashboarAddSchoolBtnClicked, status);
  }

  Future<bool> getDashboardVerifyStatus() async {
    return await getBool(SharedPrefKey.dashboarAddSchoolBtnClicked) ?? false;
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
}
