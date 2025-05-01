import 'package:halal_media/domain/entities/user.dart';
import 'package:halal_media/domain/repositories/login_repository.dart';

class GetCurrentUser {
  final LoginRepository repository;
  GetCurrentUser(this.repository);
  Future<User?> call() {
    return repository.getCurrentUser();
  }
}
