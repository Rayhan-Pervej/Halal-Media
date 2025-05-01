import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_dropdown_filed.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text_field.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/core/utils/validator.dart';
import 'package:halal_media/presentation/cubit/sign_up/sign_up_cubit.dart';
import 'package:halal_media/presentation/widgets/button/custom_text_button.dart';
import 'package:halal_media/presentation/widgets/social_buttons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    String? selectedItem;
    final signUpCubit = context.read<SignUpCubit>();
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
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
                  text: "Create an account",
                  color: AppColor.green,
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
                  key: signUpCubit.formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: signUpCubit.nameController,
                        hintText: "Name",
                        assetIcon: "assets/icons/user_white.png",
                        iconSize: 20,
                      ),
                      AppDimension.h16,
                      CustomTextField(
                        controller: signUpCubit.emailController,
                        hintText: 'Email',
                        isPassword: false,
                        assetIcon: 'assets/icons/mail_white.png',
                        iconSize: 20,
                        validator: ValidatorClass().validateEmail,
                      ),
                      AppDimension.h16,
                      CustomTextField(
                        controller: signUpCubit.passwordController,
                        hintText: 'Password',
                        isPassword: true,
                        assetIcon: 'assets/icons/lock_white.png',
                        iconSize: 20,
                        validator: ValidatorClass().validatePassword,
                      ),
                      AppDimension.h16,
                      CustomDropdownField(
                        hintText: "Preference",
                        assetIcon: 'assets/icons/prefernce_white.png',
                        iconSize: 24,
                        items: ['Video', 'Audio', 'Podcast', 'Short Clip'],
                        value: selectedItem,
                        onChanged: (value) {
                          setState(() {
                            selectedItem = value;
                          });
                        },
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Please select an item'
                                    : null,
                      ),
                    ],
                  ),
                ),
                AppDimension.h32,
                BlocBuilder<SignUpCubit, SignUpState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColor.green,
                        ),
                        onPressed:
                            state is SignUpLoading
                                ? null
                                : () {
                                  signUpCubit.signUp(context);
                                },
                        child:
                            state is SignUpLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : customText(
                                  text: "Sign up",
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
                      text: "Already have an account? ",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.black900,
                    ),
                    CustomTextButton(
                      ontap: () {
                        Navigator.pop(context);
                      },
                      text: "Log in",
                      fontSize: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
