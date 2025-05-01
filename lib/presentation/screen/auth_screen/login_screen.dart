import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/presentation/screen/auth_screen/recover_password_screen.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text_field.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/core/utils/validator.dart';
import 'package:halal_media/presentation/cubit/login/login_cubit.dart';
import 'package:halal_media/presentation/cubit/sign_up/sign_up_cubit.dart';
import 'package:halal_media/presentation/screen/auth_screen/sign_up_screen.dart';
import 'package:halal_media/presentation/widgets/button/custom_text_button.dart';
import 'package:halal_media/presentation/widgets/social_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();

    return Scaffold(
      backgroundColor: AppColor.scafoldBackground,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          /// Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/banners/login_banner.png',
              fit: BoxFit.cover,
            ),
          ),

          /// Bottom White Container on Top of Background
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  child: BlocListener<LoginCubit, LoginState>(
                    listener: (context, state) {
                      // if (state is LoginFailure) {
                      //   ScaffoldMessenger.of(
                      //     context,
                      //   ).showSnackBar(SnackBar(content: Text(state.message)));
                      // }

                      // if (state is LoginSuccess) {
                      //   // Navigate or show success
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text("Login Successful")),
                      //   );
                      // }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 250,
                          child: Image.asset(
                            'assets/icons/halal_media.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        AppDimension.h45,
                        titleText(
                          text: "Log In",
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        AppDimension.h45,

                        SocialButtons(
                          onFacebookTap: () {},
                          onGoogleTap: () {},
                          onLinkedInTap: () {},
                        ),
                        AppDimension.h45,

                        customText(
                          text: "or use your email account",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.gray600,
                        ),
                        AppDimension.h32,
                        Form(
                          key: loginCubit.formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: loginCubit.emailController,
                                hintText: 'Email',
                                isPassword: false,
                                assetIcon: 'assets/icons/mail_white.png',
                                iconSize: 20,
                                validator: ValidatorClass().validateEmail,
                              ),
                              AppDimension.h16,
                              CustomTextField(
                                controller: loginCubit.passwordController,
                                hintText: 'Password',
                                isPassword: true,
                                assetIcon: 'assets/icons/lock_white.png',
                                iconSize: 20,
                                validator: ValidatorClass().validatePassword,
                              ),
                            ],
                          ),
                        ),
                        AppDimension.h16,

                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomTextButton(
                            ontap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecoverPasswordScreen(),
                                ),
                              );
                            },
                            text: "Forgot your Password?",
                          ),
                        ),

                        AppDimension.h32,

                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              height: 44,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColor.green,
                                ),
                                onPressed:
                                    state is LoginLoading
                                        ? null
                                        : () {
                                          loginCubit.login();
                                        },
                                child:
                                    state is LoginLoading
                                        ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                        : customText(
                                          text: "Log in",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: AppColor.deepGreen,
                                        ),
                              ),
                            );
                          },
                        ),

                        AppDimension.h45,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            customText(
                              text: "Don’t you have an account? ",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black900,
                            ),
                            CustomTextButton(
                              ontap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => BlocProvider(
                                          create: (_) => SignUpCubit(),
                                          child: SignUpScreen(),
                                        ),
                                  ),
                                );
                              },
                              text: "Sign up",
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
