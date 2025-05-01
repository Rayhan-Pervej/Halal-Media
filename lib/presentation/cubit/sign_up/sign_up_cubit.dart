import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/domain/entities/user.dart';
import 'package:halal_media/presentation/screen/home_screen/varification/varification_cubit.dart';
import 'package:halal_media/presentation/screen/auth_screen/varification_screen.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> signUp(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => BlocProvider(
              create: (_) => VarificationCubit(),
              child: VarificationScreen(),
            ),
      ),
    );
  }
}
