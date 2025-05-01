part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}
final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final User user;

  SignUpSuccess(this.user);
}

final class SignUpFailure extends SignUpState {
  final String message;

  SignUpFailure(this.message);
}