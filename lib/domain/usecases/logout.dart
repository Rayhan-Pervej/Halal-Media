import 'package:halal_media/domain/repositories/login_repository.dart';

class Logout {
  final LoginRepository repository;
  Logout(this.repository);
  Future<void> call() {
    return repository.logout();
  }
}
