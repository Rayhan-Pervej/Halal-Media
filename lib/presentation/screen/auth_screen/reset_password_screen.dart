import 'package:flutter/material.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/presentation/widgets/button/custom_text_button.dart';
import 'package:hexcolor/hexcolor.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: Image.asset(
                    'assets/icons/halal_media.png',
                    fit: BoxFit.contain,
                  ),
                ),
                AppDimension.h45,

                _emailIcon(),
                AppDimension.h45,
                titleText(
                  text: "Reset your password",
                  color: AppColor.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
                AppDimension.h45,
                Column(
                  children: [
                    customText(
                      text: "You're almost there! We have sent an email to",
                      fontSize: 14,
                      color: AppColor.black800,
                    ),
                    customText(
                      text: "rayhan.pervej@gmail.com",
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColor.black800,
                    ),
                  ],
                ),
                AppDimension.h45,
                customText(
                  text:
                      "You need to verify you email to continue. If you have not received the verification email, please check your “Spam” or “Bulk Email” folder. You can also click the resend button below to have another email sent to you.",
                  fontSize: 14,
                  color: AppColor.black800,
                ),
                AppDimension.h32,
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColor.green,
                    ),
                    onPressed: () {},
                    child: customText(
                      text: "Continue",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColor.deepGreen,
                    ),
                  ),
                ),

                AppDimension.h45,

                CustomTextButton(
                  ontap: () {},
                  text: "Resent the email",
                  color: AppColor.deepGreen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: HexColor("#EBFEF6"),
            borderRadius: BorderRadius.circular(128),
          ),
        ),
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: HexColor("#D2F8DE"),
            borderRadius: BorderRadius.circular(100),
          ),
        ),

        SizedBox(child: Image.asset("assets/icons/mail_green.png", height: 31)),
      ],
    );
  }
}
