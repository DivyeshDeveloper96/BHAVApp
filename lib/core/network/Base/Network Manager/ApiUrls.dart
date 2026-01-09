enum AppEnvironment { dev, prod }

class ApiUrls {
  // Set the current environment here
  static const AppEnvironment env = AppEnvironment.dev;

  // Use getter to return baseUrl based on the environment
  static String get baseUrl {
    switch (env) {
      case AppEnvironment.prod:
        return 'https://vaishnav-swami-yatra-api-yxnv.vercel.app';
      case AppEnvironment.dev:
      default:
        return 'https://vaishnav-swami-yatra-api-yxnv.vercel.app';
    }
  }

  // Define your API endpoints
  static String get loginSentOTP => '$baseUrl/auth/otp';

  static String get verifyOtp => '$baseUrl/auth/verify';

  static String get getYatraListUrl => '$baseUrl/admin/yatras?includeClosed=false';

  static String get getProfileUrl => '$baseUrl/api/v2/users/profile-detail';

}
