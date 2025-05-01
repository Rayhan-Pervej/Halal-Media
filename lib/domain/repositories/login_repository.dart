import 'package:halal_media/domain/entities/user.dart';

abstract class LoginRepository {
  Future<User> loginWithEmail(String email, String password);

  Future<void> logout();

  Future<bool> isLoggedIn();

  Future<User?> getCurrentUser();
}