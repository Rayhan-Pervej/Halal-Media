import 'package:halal_media/data/sources/login_remote_sources.dart';
import 'package:halal_media/domain/entities/user.dart';
import 'package:halal_media/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteSources remoteSources;

  LoginRepositoryImpl(this.remoteSources);

  @override
  Future<User> loginWithEmail(String email, String password) async {
    final userData = await remoteSources.loginWithEmail(email, password);
    return userData.toEntity(); 
  }

  @override
  Future<void> logout() async {
    await remoteSources.logout();
  }

  @override
  Future<User?> getCurrentUser() async {
    final userModel = await remoteSources.getCurrentUser();
    return userModel?.toEntity();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await remoteSources.isLoggedIn();
  }
}
