import 'package:dio/dio.dart';
import 'package:halal_media/core/constants/api_constants.dart';
import 'package:halal_media/data/models/user_model.dart';
import 'package:halal_media/data/sources/login_remote_sources.dart';

class LoginRemoteSourcesImpl implements LoginRemoteSources {
  final Dio dio;

  LoginRemoteSourcesImpl(this.dio);

  @override
  Future<UserModel> loginWithEmail(String email, String password) async {
    final response = await dio.post(
      ApiConstants.login,
      data: {"email": email, "password": password},
    );
    print("Login response: ${response.data}");

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception("Login failed");
    }
  }

  @override
  Future<void> logout() async {
    await dio.post(ApiConstants.logout);
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final response = await dio.get(ApiConstants.getCurrentUser);

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final response = await dio.get(ApiConstants.getCurrentUser);
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
