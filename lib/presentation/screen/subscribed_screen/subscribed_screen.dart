import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/data/repositories/profile_repo.dart';
import 'package:halal_media/presentation/cubit/subscribed/subscribed_cubit.dart';
import 'package:halal_media/presentation/widgets/button/custom_rounded_text_button.dart';
import 'package:halal_media/presentation/widgets/custom_appbar.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_progress_indicator.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class SubscribedScreen extends StatelessWidget {
  final String userId;

  const SubscribedScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => SubscribedCubit(ProfileRepo())..loadSubscribedUsers(userId),
      child: BlocBuilder<SubscribedCubit, SubscribedState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColor.white,
            appBar: CustomAppbar(bottomBorder: true),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildBody(context, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, SubscribedState state) {
    if (state is SubscribedLoading) {
      return const Center(child: CustomProgressIndicator());
    } else if (state is SubscribedLoaded) {
      return ListView.builder(
        itemCount: state.subscribedUsers.length,
        itemBuilder: (context, index) {
          final user = state.subscribedUsers[index];
          final isLoading = state.loadingUserIds.contains(user.id);

          return _channelCard(
            onTap: () {},
            channelName: user.channelName,
            totalSubsriber: "${user.subscribers.length}",
            profileImage: 'assets/icons/avatar_${index % 2 + 1}.png',
            userName: user.username ?? '',
            isLoading: isLoading,
            onSubscribeTap: () {
              context.read<SubscribedCubit>().toggleSubscription(user);
            },
          );
        },
      );
    } else if (state is SubscribedError) {
      return Center(child: Text(state.message));
    }

    return const SizedBox();
  }

  Widget _channelCard({
    required VoidCallback onTap,
    required String channelName,
    required String totalSubsriber,
    required String userName,
    required VoidCallback onSubscribeTap,
    required String profileImage,
    required bool isLoading,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Image.asset(profileImage, fit: BoxFit.cover),
                ),
                AppDimension.w16,
                SizedBox(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: channelName,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),

                      customText(
                        text: "@$userName",
                        fontSize: 12,

                        overflow: TextOverflow.ellipsis,
                      ),
                      AppDimension.h2,
                      customText(
                        text: "$totalSubsriber subscribers",
                        fontSize: 12,

                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
              width: 40,
              child:
                  isLoading
                      ? Center(
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.black,
                            ),
                          ),
                        ),
                      )
                      : _threeDotButton(
                        isLoading: isLoading,
                        onSubscribeTap: onSubscribeTap,
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _threeDotButton({
    required bool isLoading,
    required VoidCallback onSubscribeTap,
  }) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      iconColor: AppColor.deepGreen,
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: AppColor.white,
      onSelected: (value) {
        if (value == 'subscribe') {
          onSubscribeTap();
        }
      },
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: 'subscribe',
              child: SizedBox(
                width: double.infinity, // Ensures button fits nicely
                child: customText(
                  text: 'Subscribed',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.black900,
                ),
              ),
            ),
          ],
    );
  }
}
