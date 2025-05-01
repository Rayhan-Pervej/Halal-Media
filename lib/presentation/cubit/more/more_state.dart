part of 'more_cubit.dart';

@immutable
sealed class MoreState {}

final class MoreInitial extends MoreState {}

final class Logoutloading extends MoreState {}

final class Logoutloaded extends MoreState {
  final String message;
  Logoutloaded(this.message);
}
final class LogoutError extends MoreState {
  final String message;
   LogoutError(this.message);
}
