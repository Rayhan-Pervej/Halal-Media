import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/presentation/screen/home_screen/varification/varification_cubit.dart';
import 'package:halal_media/presentation/widgets/button/custom_text_button.dart';
import 'package:hexcolor/hexcolor.dart';

class VarificationScreen extends StatelessWidget {
  const VarificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final varificationCubit = context.read<VarificationCubit>();
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
                  text: "Please verify your email",
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
                BlocBuilder<VarificationCubit, VarificationState>(
                  builder: (context, state) {
                    final isLoading = state is ContinueLoading;

                    return SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColor.green,
                        ),
                        onPressed:
                            isLoading
                                ? null
                                : () {
                                  varificationCubit.varification(context);
                                },
                        child:
                            isLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : customText(
                                  text: "Continue",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: AppColor.deepGreen,
                                ),
                      ),
                    );
                  },
                ),

                AppDimension.h45,
                BlocBuilder<VarificationCubit, VarificationState>(
                  builder: (context, state) {
                    if (state is ResendCountdownState) {
                      return customText(
                        text:
                            "Resend Verification Email in ${state.secondsRemaining}",
                        fontSize: 14,
                        color: AppColor.black600,
                      );
                    }

                    return CustomTextButton(
                      ontap: () {
                        varificationCubit.resendVerificationEmail();
                      },
                      text: "Resend Verification Email",
                      color: AppColor.deepGreen,
                    );
                  },
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
