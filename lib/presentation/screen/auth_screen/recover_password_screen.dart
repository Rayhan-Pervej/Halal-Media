import 'package:flutter/material.dart';
import 'package:halal_media/presentation/screen/auth_screen/reset_password_screen.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text_field.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/core/utils/validator.dart';
import 'package:halal_media/presentation/widgets/button/custom_text_button.dart';

class RecoverPasswordScreen extends StatelessWidget {
  const RecoverPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  text: "Recover your password",
                  color: AppColor.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                AppDimension.h45,

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 14, color: AppColor.black600),
                    children: [
                      const TextSpan(
                        text: 'Enter the email ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                            'that you used when register to recover your password. You will receive a ',
                      ),
                      const TextSpan(
                        text: 'password reset link.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                AppDimension.h45,
                CustomTextField(
                  controller: TextEditingController(),
                  hintText: 'Email',
                  isPassword: false,
                  assetIcon: 'assets/icons/mail_white.png',
                  iconSize: 20,
                  validator: ValidatorClass().validateEmail,
                ),
                AppDimension.h32,
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColor.green,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen(),
                        ),
                      );
                    },
                    child: customText(
                      text: "Continue",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColor.deepGreen,
                    ),
                  ),
                ),

                // BlocBuilder<LoginCubit, LoginState>(
                //             builder: (context, state) {
                //               return SizedBox(
                //                 width: double.infinity,
                //                 height: 44,
                //                 child: TextButton(
                //                   style: TextButton.styleFrom(
                //                     backgroundColor: AppColor.green,
                //                   ),
                //                   onPressed:
                //                       state is LoginLoading
                //                           ? null
                //                           : () {
                //                             loginCubit.login();
                //                           },
                //                   child:
                //                       state is LoginLoading
                //                           ? const CircularProgressIndicator(
                //                             color: Colors.white,
                //                           )
                //                           : customText(
                //                             text: "Log in",
                //                             fontWeight: FontWeight.w500,
                //                             fontSize: 14,
                //                             color: AppColor.deepGreen,
                //                           ),
                //                 ),
                //               );
                //             },
                //           ),
                AppDimension.h45,
                customText(
                  text: "If you need further assistance",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black800,
                ),
                CustomTextButton(
                  ontap: () {},
                  text: "contact our support team",
                  fontSize: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
