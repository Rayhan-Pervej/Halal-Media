import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/domain/repositories/login_repository.dart';
import 'package:halal_media/domain/entities/user.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginCubit(this.loginRepository) : super(LoginInitial());

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      //emit(LoginFailure("Invalid email or password"));
      return;
    }

    emit(LoginLoading());

    try {
      final user = await loginRepository.loginWithEmail(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginFailure(e.toString()));
      print(e.toString());
      
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
