import 'package:halal_media/domain/entities/user.dart';
import 'package:halal_media/domain/repositories/login_repository.dart';

class LoginWithEmail {
  final LoginRepository loginRepository;

  LoginWithEmail({required this.loginRepository});

  Future<User> call(String email, String password) async {
    return loginRepository.loginWithEmail(email, password);
  }
}
