import 'package:halal_media/data/models/user_model.dart';

abstract class LoginRemoteSources {
  Future<UserModel> loginWithEmail(String email, String password);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
  Future<bool> isLoggedIn();
}
