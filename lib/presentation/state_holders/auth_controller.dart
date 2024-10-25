import 'dart:convert';

import 'package:ecommerce/data/models/user_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final String _accessTokenKey = 'access-token';
  final String _userProfileKey = 'user-profile';
  static String? accessToken;
  static UserProfileModel? userProfileData;

  Future<void> saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
  }

  Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString(_accessTokenKey);
    accessToken = token;
    return token;
  }

  bool isLoggedInUser() {
    return accessToken != null;
  }

  Future<void> saveUserProfileData(UserProfileModel userProfile) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
      _userProfileKey,
      jsonEncode(userProfile.toJson()),
    );
    userProfileData = userProfile;
  }

  Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
