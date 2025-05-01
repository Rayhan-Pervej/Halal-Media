import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/core/utils/validator.dart';
import 'package:halal_media/presentation/cubit/my_profile/my_profile_cubit.dart';
import 'package:halal_media/presentation/widgets/button/custom_rounded_text_button.dart';
import 'package:halal_media/presentation/widgets/custom_appbar.dart';
import 'package:halal_media/presentation/widgets/custom_divider.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_input_field.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_progress_indicator.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  void initState() {
    super.initState();

    // Trigger loading of user data
    context.read<MyProfileCubit>().userData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppbar(
        isNavbar: false,
        title: "My Profile",
        bottomBorder: true,
      ),
      body: BlocBuilder<MyProfileCubit, MyProfileState>(
        builder: (context, state) {
          if (state is MyProfileInitial || state is MyProfileLoading) {
            return Center(child: CustomProgressIndicator());
          }
          if (state is MyProfileFormState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 220,
                    child: Stack(
                      children: [
                        // Banner image section
                        GestureDetector(
                          onTap:
                              () =>
                                  context
                                      .read<MyProfileCubit>()
                                      .pickBannerImage(),
                          child: Stack(
                            children: [
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child:
                                    state.bannerImage != null
                                        ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Image.file(
                                            state
                                                .bannerImage!, // Use state.bannerImage here
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        )
                                        : Image.asset(
                                          'assets/banners/channel_banner.png',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                              ),
                              Positioned(
                                right: 10,
                                bottom: 10,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColor.black900.withAlpha(100),

                                    borderRadius: BorderRadius.circular(360),
                                  ),

                                  child: ClipRRect(
                                    child: Image.asset(
                                      'assets/icons/camera.png', // Use state.bannerImage here
                                      fit: BoxFit.contain,
                                      width: 28,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Profile image section
                        Positioned(
                          bottom: 0,
                          left: 16,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap:
                                    () =>
                                        context
                                            .read<MyProfileCubit>()
                                            .pickProfileImage(),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          360,
                                        ),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          360,
                                        ),
                                        child:
                                            state.profileImage != null
                                                ? Image.file(
                                                  state
                                                      .profileImage!, // Use state.profileImage here
                                                  fit: BoxFit.cover,
                                                )
                                                : Image.asset(
                                                  'assets/banners/profile.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: ClipRRect(
                                        child: Image.asset(
                                          'assets/icons/camera_black.png', // Use state.bannerImage here
                                          fit: BoxFit.contain,
                                          width: 32,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              AppDimension.w16,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(
                                    text: state.nameController.text,
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  customText(
                                    text: state.emailController.text,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  AppDimension.h16,
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppDimension.h16,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppDimension.h10,
                        customText(
                          text: "Personal Info",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.green,
                        ),
                        AppDimension.h10,
                        CustomDivider(height: 1),
                        AppDimension.h10,
                        CustomInputField(
                          label: "Your Channel Name",
                          controller: state.channelNameController,
                          maxLength: 20,
                          validatorClass: ValidatorClass().validateChannelName,
                        ),
                        CustomInputField(
                          label: "Your Name",
                          controller: state.nameController,
                          maxLength: 20,
                          validatorClass: ValidatorClass().validateChannelName,
                        ),
                        CustomInputField(
                          label: "Email",
                          controller: state.emailController,
                          maxLength: 20,
                          validatorClass: ValidatorClass().validateEmail,
                        ),
                        CustomInputField(
                          label: "Handle",
                          controller: state.handleController,
                          maxLength: 20,
                        ),
                        CustomInputField(
                          label: "Description",
                          controller: state.descriptionController,
                          maxLength: 1500,
                          isMultiline: true,
                        ),
                        CustomInputField(
                          label: "Channel Url",
                          controller: state.channelUrlController,
                          maxLength: 100,
                        ),
                        AppDimension.h10,
                        CustomDivider(height: 1),
                        AppDimension.h10,
                        customText(
                          text: "Social Link",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.green,
                        ),
                        AppDimension.h10,
                        CustomDivider(height: 1),
                        AppDimension.h10,

                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: Opacity(
                                opacity: .3,
                                child: Image.asset(
                                  'assets/icons/x.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            ),
                            AppDimension.w8,
                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: Opacity(
                                opacity: .3,
                                child: Image.asset(
                                  'assets/icons/facebook.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            ),
                            AppDimension.w8,

                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: Opacity(
                                opacity: .3,
                                child: Image.asset(
                                  'assets/icons/whatsapp.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            ),
                            AppDimension.w8,
                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: Opacity(
                                opacity: 0.3,
                                child: Image.asset(
                                  'assets/icons/linkedin.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            ),
                            AppDimension.w8,
                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: Opacity(
                                opacity: 0.3,
                                child: Image.asset(
                                  'assets/icons/tiktok.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                        AppDimension.h20,
                      ],
                    ),
                  ),

                  BlocBuilder<MyProfileCubit, MyProfileState>(
                    builder: (context, state) {
                      if (state is MyProfileFormState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomRoundedTextButton(
                              backgroundColor: AppColor.green,
                              borderColor: AppColor.gray200,
                              textColor: AppColor.black900,
                              horizontalPadding: 32,
                              onPressed:
                                  state.isSavingLoading
                                      ? null
                                      : () {
                                        context
                                            .read<MyProfileCubit>()
                                            .saveUserProfile();
                                      },
                              child:
                                  state.isSavingLoading
                                      ? SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                AppColor.black200,
                                              ),
                                        ),
                                      )
                                      : customText(
                                        text: "Save",
                                        color: AppColor.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                            ),
                          ],
                        );
                      } else if (state is MyProfileError) {
                        return Center(child: Text("Error: ${state.message}"));
                      }

                      return const SizedBox();
                    },
                  ),

                  AppDimension.h32,
                ],
              ),
            );
          } else if (state is MyProfileError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          return const SizedBox();
        },
      ),
    );
  }
}

//  Scaffold(
//       backgroundColor: AppColor.white,
//       appBar: CustomAppbar(
//         isNavbar: false,
//         title: "My Profile",
//         bottomBorder: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 215,
//               child: Stack(
//                 children: [
//                   Container(
//                     height: 150,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Image.asset(
//                       'assets/banners/channel_banner.png',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     child: ChannelHeaderCard(
//                       imagePath: 'assets/banners/profile.jpg',
//                       channelName: 'Your Channel',
//                       subscriberCount: '14.1M Subscriber',
//                       userName: 'Rayhan Pervej ',
//                       onUserTap: () {
//                         // Navigate or show profile details
//                       },
//                       onViewPressed: () {
//                         // Handle "View"
//                       },
//                       onCustomizePressed: () {
//                         // Handle "Customize"
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             AppDimension.h32,
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   AppDimension.h10,
//                   customText(
//                     text: "Description",
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: AppColor.green,
//                   ),
//                   AppDimension.h10,
//                   CustomDivider(height: 1),
//                   AppDimension.h10,
//                   customText(
//                     text:
//                         "May the peace and blessings of God/Allah be upon you To promote accurate representation of Islam by providing correct information thereby encouraging individual responsibility for seeking and acting upon the Truth. Guide people to Islam through the authentic sources of the Quran and Sunnah in a contemporary way with the understanding of the righteous predecessors.I’ve no issue Re-upload anything from my channel as long as people’s benefiting from it. Remember me in your precious DuasAny of the views expressed by the speakers on this channel do not necessarily represent the views of FurqanTube. We do not advocate nor condone any unlawful activity towards any individual or communities.Jazak Allahu Khayran (جزاك اللهُ خيرًا)",
//                   ),
//                   AppDimension.h10,
//                   CustomDivider(height: 1),
//                   AppDimension.h10,
//                   customText(
//                     text: "Social Link",
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: AppColor.green,
//                   ),
//                   AppDimension.h10,
//                   CustomDivider(height: 1),
//                   AppDimension.h10,

//                   Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {},
//                         padding: EdgeInsets.zero,
//                         constraints: const BoxConstraints(),
//                         icon: Image.asset(
//                           'assets/icons/x.png',
//                           height: 40,
//                           width: 40,
//                         ),
//                       ),
//                       AppDimension.w8,
//                       IconButton(
//                         onPressed: () {},
//                         padding: EdgeInsets.zero,
//                         constraints: const BoxConstraints(),
//                         icon: Image.asset(
//                           'assets/icons/facebook.png',
//                           height: 40,
//                           width: 40,
//                         ),
//                       ),
//                       AppDimension.w8,

//                       IconButton(
//                         onPressed: () {},
//                         padding: EdgeInsets.zero,
//                         constraints: const BoxConstraints(),
//                         icon: Image.asset(
//                           'assets/icons/whatsapp.png',
//                           height: 40,
//                           width: 40,
//                         ),
//                       ),
//                       AppDimension.w8,
//                       IconButton(
//                         onPressed: () {},
//                         padding: EdgeInsets.zero,
//                         constraints: const BoxConstraints(),
//                         icon: Image.asset(
//                           'assets/icons/linkedin.png',
//                           height: 40,
//                           width: 40,
//                         ),
//                       ),
//                       AppDimension.w8,
//                       IconButton(
//                         onPressed: () {},
//                         padding: EdgeInsets.zero,
//                         constraints: const BoxConstraints(),
//                         icon: Image.asset(
//                           'assets/icons/tiktok.png',
//                           height: 40,
//                           width: 40,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
