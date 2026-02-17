// lib/models/user_model.dart
class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? gender;
  String? initiatedName;
  String? country;
  String? state;
  String? city;
  String? profileImage;
  String? token;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.gender,
    this.initiatedName,
    this.country,
    this.state,
    this.city,
    this.profileImage,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      initiatedName: json['initiatedName'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      profileImage: json['profileImage'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'gender': gender,
      'initiatedName': initiatedName,
      'country': country,
      'state': state,
      'city': city,
      'profileImage': profileImage,
      'token': token,
    };
  }

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();
}
