enum AppEnvironment { dev, prod }

class ApiUrls {
  // Set the current environment here
  static const AppEnvironment env = AppEnvironment.dev;

  // Use getter to return baseUrl based on the environment
  static String get baseUrl {
    switch (env) {
      case AppEnvironment.prod:
        return 'https://prashast.ncert.gov.in';
      case AppEnvironment.dev:
      default:
        return 'http://80.225.202.21';
    }
  }

  // Define your API endpoints
  static String get loginUrl => '$baseUrl/login';

  static String get registerUrl => '$baseUrl/register';

  static String get getProfileUrl => '$baseUrl/api/v2/users/profile-detail';

  static String get updateProfileImageUrl =>
      "$baseUrl/api/v2/users/upload-profile-cloud-image";

  static String get updateDikshaIdUrl =>
      "$baseUrl/api/v2/users/verify/update-dikshaId";

  static String get updateApaarIdUrl =>
      "$baseUrl/api/v2/users/verify/update-apaarId";

  static String get updateSchoolUrl =>
      "$baseUrl/api/v2/notification/transfer-request";

  static String get getLanguageUrl =>
      '$baseUrl/api/v2/system/get-language-list';

  static String get getLanguageContentUrl =>
      '$baseUrl/api/v2/system/get-language-list';

  static String get getDashPrincipleOverview =>
      '$baseUrl/api/v2/users/head-teacher-dashboard';

  static String get updateLanguageUrl => '$baseUrl/api/v2/system/save-language';

  // add teacher
  static String get addTeacherUrl => '$baseUrl/api/v2/users/add/teacher';

  static String get generateOtpUrl => '$baseUrl/api/v2/partner/generate-otp';

  static String get verifyOTP => '$baseUrl/api/v2/partner/verify-otp';

  static String get mapSchoolTeacher =>
      '$baseUrl/api/v2/teacher/map-school/teacher';

  static String get mapSchoolSpecialEducator =>
      '$baseUrl/api/v2/teacher/map-school/special-educator';

  static String get addAssignScreening1 => '$baseUrl/api/v2/screening/add/1';

  static String get updateAssignScreening1 =>
      '$baseUrl/api/v2/screening/update';

  static String get addAssignScreening2 => '$baseUrl/api/v2/screening/add/2';

  static String get notificationCount => '$baseUrl/api/v2/notification/count';

  static String get getSchooldDetail =>
      '$baseUrl/api/v2/special-educator/get-school-detail';

  static String get addSchool => '$baseUrl/api/v2/special-educator/add-school';

  static String get getScreeingClassList =>
      '$baseUrl/api/v2/screening/school/screening-class-list';

  static String get getScreeingStudentList =>
      '$baseUrl/api/v2/screening/school/class/student-list';

  static String get getDisabilities => '$baseUrl/api/v2/system/disability-list';

  static String get getDisabilitiesQuestions =>
      '$baseUrl/api/v2/system/screening/question/list/2';

  static String get saveScreening2 =>
      '$baseUrl/api/v2/teacher/save/final-screening';

  // static String get getScreening2History =>
  //     '$baseUrl/api/v2/student/screening/full-history';

  static String get getTeacherByPrashastId =>
      '$baseUrl/api/v2/teacher/prashast-id/';

  static String get getSpecialEducaotrByPrashastId =>
      '$baseUrl/api/v2/special-educator/prashast-id/';

  static String get getTeacherList => '$baseUrl/api/v2/teacher/list';

  static String get verifyPrashastId =>
      '$baseUrl/api/v2/teacher/get-teacher-detail-by-prashastId/';

  static String get getClassesUrl => '$baseUrl/api/v2/screening/classes';

  static String get getClasses2Url => '$baseUrl/api/v2/screening/classes/2';

  static String get getStatusUrl => '$baseUrl/api/v2/screening/status-list';

  static String get getGenderUrl => '$baseUrl/api/v2/system/get-genders';

  static String get getAcademicYearUrl =>
      '$baseUrl/api/v2/system/academic-year-list';

  static String get getScreeningTypeUrl => '$baseUrl/api/v2/screening/types';

  static String get generateScreeningReport =>
      '$baseUrl/api/v2/screening/generate/report';

  static String get getMySurveyReportList =>
      '$baseUrl/api/v2/screening/survey/part/';
  static String get getMySurveyReportListOtherFYear =>
      '$baseUrl/api/v2/screening/previous/survey/report';

  static String get getAssignScreeningList => '$baseUrl/api/v2/screening/list/';

  static String get getManageSPList => '$baseUrl/api/v2/special-educator/list';

  static String get removeSEfromHT => '$baseUrl/api/v2/users/remove/';

  static String get actionSEFromHT => '$baseUrl/api/v2/notification/';

  //faq list
  static String get getFaqList => '$baseUrl/api/v2/config/get-faq-list';

  //help and support
  static String get getHelpAndSupport =>
      '$baseUrl/api/v2/config/get-page-details';

  //notification list
  static String get getNotificationList => '$baseUrl/api/v2/notification/list';

  //notification detail
  static String get getNotificationDetail =>
      '$baseUrl/api/v2/notification/detail';

  static String get updateNotificationStatus =>
      '$baseUrl/api/v2/notification/update-read-status';

  static String get getTeacherDropdown => '$baseUrl/api/v2/teacher/dropdown';

  //Teacher Role API
  static String get getDashTeachereOverview =>
      '$baseUrl/api/v2/teacher/dashboard';

  static String get getScreeningPartList =>
      '$baseUrl/api/v2/teacher/screening/list';

  static String get loginWithMeriphachan =>
      '$baseUrl/api/v2/auth/login-with-meripehchaan';

  static String get checkReviewStatus =>
      '$baseUrl/api/v2/users/checkReviewStatus/';

  static String get getDisabilitiesQuestScreeningForm1 =>
      '$baseUrl/api/v2/system/screening/question/list/1';

  static String get getRoleList => '$baseUrl/api/v2/config/get-roles';

  //add udise id
  static String get addUdiseId => '$baseUrl/api/v2/users/add/udise';

  //registeruser
  static String get registerUser => '$baseUrl/api/v2/users/register';

  static String get getDisabilitiesSavedHistory =>
      '$baseUrl/api/v2/student/screening-history';

  static String get postSaveSubmitScreeningFormP1 => '$baseUrl/api/v2/teacher/';

  static String get teacherAddSchool => '$baseUrl/api/v2/teacher/add-school';

  static String get studentList => '$baseUrl/api/v2/student/list';

  static String get studentAddNew => '$baseUrl/api/v2/student/add/new';

  static String get updateStudent => '$baseUrl/api/v2/student/update';

  static String get studentRemove => '$baseUrl/api/v2/student/mutiple/delete';

  static String get studentDetails => '$baseUrl/api/v2/student/details';

  static String get uploadCVSFile => '$baseUrl/api/v2/student/upload/csv';

  static String get importStudentData => '$baseUrl/api/v2/student/import';

  static String get loginthroughMeriPehchan =>
      '$baseUrl/api/v2/auth/redirect-to-digilocker';

  static String get importSaveStudentData =>
      '$baseUrl/api/v2/student/save-imported-student';

  static String get mySchoolList =>
      '$baseUrl/api/v2/special-educator/my-school-list';

  static String get getAppVersionUrl => '$baseUrl/api/v2/users/app-version/';
  static String get getUserRoles => '$baseUrl/api/v2/users/get-user-roles';
  static String get setUserRolesSchool =>
      '$baseUrl/api/v2/users/set-user-roles-school';

  static String get getDownloadReportUrl =>
      '$baseUrl/api/v2/reports/classwise-screening-one';

  static String get getDownloadReportConsolidateUrl =>
      '$baseUrl/api/v2/reports/';
}
