class VerifyOtpModel {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  int? expiresAt;
  String? refreshToken;
  User? user;

  VerifyOtpModel(
      {this.accessToken,
        this.tokenType,
        this.expiresIn,
        this.expiresAt,
        this.refreshToken,
        this.user});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    expiresAt = json['expires_at'];
    refreshToken = json['refresh_token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['expires_at'] = this.expiresAt;
    data['refresh_token'] = this.refreshToken;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? aud;
  String? role;
  String? email;
  String? phone;
  String? phoneConfirmedAt;
  String? confirmationSentAt;
  String? confirmedAt;
  String? lastSignInAt;
  AppMetadata? appMetadata;
  UserMetadata? userMetadata;
  List<Identities>? identities;
  String? createdAt;
  String? updatedAt;
  bool? isAnonymous;

  User(
      {this.id,
        this.aud,
        this.role,
        this.email,
        this.phone,
        this.phoneConfirmedAt,
        this.confirmationSentAt,
        this.confirmedAt,
        this.lastSignInAt,
        this.appMetadata,
        this.userMetadata,
        this.identities,
        this.createdAt,
        this.updatedAt,
        this.isAnonymous});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aud = json['aud'];
    role = json['role'];
    email = json['email'];
    phone = json['phone'];
    phoneConfirmedAt = json['phone_confirmed_at'];
    confirmationSentAt = json['confirmation_sent_at'];
    confirmedAt = json['confirmed_at'];
    lastSignInAt = json['last_sign_in_at'];
    appMetadata = json['app_metadata'] != null
        ? AppMetadata.fromJson(json['app_metadata'])
        : null;
    userMetadata = json['user_metadata'] != null
        ? UserMetadata.fromJson(json['user_metadata'])
        : null;
    if (json['identities'] != null) {
      identities = <Identities>[];
      json['identities'].forEach((v) {
        identities!.add(Identities.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isAnonymous = json['is_anonymous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['aud'] = this.aud;
    data['role'] = this.role;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['phone_confirmed_at'] = this.phoneConfirmedAt;
    data['confirmation_sent_at'] = this.confirmationSentAt;
    data['confirmed_at'] = this.confirmedAt;
    data['last_sign_in_at'] = this.lastSignInAt;
    if (this.appMetadata != null) {
      data['app_metadata'] = this.appMetadata!.toJson();
    }
    if (this.userMetadata != null) {
      data['user_metadata'] = this.userMetadata!.toJson();
    }
    if (this.identities != null) {
      data['identities'] = this.identities!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_anonymous'] = this.isAnonymous;
    return data;
  }
}

class AppMetadata {
  String? provider;
  List<String>? providers;

  AppMetadata({this.provider, this.providers});

  AppMetadata.fromJson(Map<String, dynamic> json) {
    provider = json['provider'];
    providers = json['providers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['provider'] = this.provider;
    data['providers'] = this.providers;
    return data;
  }
}

class UserMetadata {
  bool? emailVerified;
  bool? phoneVerified;
  String? sub;

  UserMetadata({this.emailVerified, this.phoneVerified, this.sub});

  UserMetadata.fromJson(Map<String, dynamic> json) {
    emailVerified = json['email_verified'];
    phoneVerified = json['phone_verified'];
    sub = json['sub'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email_verified'] = this.emailVerified;
    data['phone_verified'] = this.phoneVerified;
    data['sub'] = this.sub;
    return data;
  }
}

class Identities {
  String? identityId;
  String? id;
  String? userId;
  UserMetadata? identityData;
  String? provider;
  String? lastSignInAt;
  String? createdAt;
  String? updatedAt;

  Identities(
      {this.identityId,
        this.id,
        this.userId,
        this.identityData,
        this.provider,
        this.lastSignInAt,
        this.createdAt,
        this.updatedAt});

  Identities.fromJson(Map<String, dynamic> json) {
    identityId = json['identity_id'];
    id = json['id'];
    userId = json['user_id'];
    identityData = json['identity_data'] != null
        ? UserMetadata.fromJson(json['identity_data'])
        : null;
    provider = json['provider'];
    lastSignInAt = json['last_sign_in_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identity_id'] = this.identityId;
    data['id'] = this.id;
    data['user_id'] = this.userId;
    if (this.identityData != null) {
      data['identity_data'] = this.identityData!.toJson();
    }
    data['provider'] = this.provider;
    data['last_sign_in_at'] = this.lastSignInAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}