import 'package:bhavapp/modules/home/model/yatraListModel.dart';

import '../../../../modules/yatras/model/yatraDetails_model.dart';
import '../../../../shared/common.dart';
import 'ApiTaskCode.dart';

class TaskParserRegistry {
  static final Map<ApiTaskCode, dynamic Function(dynamic)> _parsers = {
    /* ApiTaskCode.fetchProfile: (json) =>
        ProfileDetailResponseModel.fromJson(json),
    ApiTaskCode.getLangauagesList: (json) =>
        (json as List).map((e) => LanguageListResponse.fromJson(e)).toList(),
    ApiTaskCode.updateLanguage: (json) => LanguageSaveResponse.fromJson(json),
    ApiTaskCode.getDashPrincipleOverview: (json) =>
        (json as List).map((e) => DashOverviewModel.fromJson(e)).toList(),*/
    ApiTaskCode.verifyOTP: (json) => json,
    ApiTaskCode.loginSentOTP: (json) => json,
    ApiTaskCode.getYatraList:
        (json) =>
            (json as List).map((e) => YatraListModel.fromJson(e)).toList(),
    ApiTaskCode.getYatraDetails:
        (json) => YatraDetailsModel.fromJson(Map<String, dynamic>.from(json)),
  };

  static T parse<T>(ApiTaskCode task, dynamic data) {
    final parser = _parsers[task];

    if (parser == null) {
      printValue("❌ No parser registered for task: $task");
      throw Exception("No parser registered for task: $task");
    }

    try {
      return parser(data) as T;
    } catch (e, stackTrace) {
      printValue("❌ Failed to parse API response for task: $task");
      printValue("🔍 Error: $e");
      printValue("📦 Raw Data: $data");
      printValue("📄 Stack Trace: $stackTrace");
      printValue("📄 Stack Trace: $stackTrace");
      throw Exception("Parsing error for $task: $e");
    }
  }
}
