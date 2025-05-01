import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:iconsax/iconsax.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/presentation/widgets/shared_widgets/custom_text%20_widget.dart';

class VideoPicker extends StatelessWidget {
  final VideoPlayerController? controller;
  final File? videoFile;
  final VoidCallback onPickVideo;
  final bool isMuted;
  final bool isPlaying;
  final VoidCallback onTogglePlayPause;
  final VoidCallback onToggleMute;

  const VideoPicker({
    super.key,
    required this.controller,
    required this.videoFile,
    required this.onPickVideo,
    required this.isMuted,
    required this.isPlaying,
    required this.onTogglePlayPause,
    required this.onToggleMute,
  });

  Widget _iconButton(String assetName, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        'assets/icons/video_player/$assetName',
        height: 16,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isVideoReady =
        videoFile != null &&
        controller != null &&
        controller!.value.isInitialized;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: .5, color: AppColor.black600),
        ),
        child:
            isVideoReady
                ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AspectRatio(
                        aspectRatio: controller!.value.aspectRatio,
                        child: VideoPlayer(controller!),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 16,
                      child: Column(
                        children: [
                          VideoProgressIndicator(
                            controller!,
                            allowScrubbing: true,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 2,
                            ),
                            colors: VideoProgressColors(
                              playedColor: AppColor.green,
                              bufferedColor: AppColor.black200,
                              backgroundColor: AppColor.black400,
                            ),
                          ),
                          AppDimension.h8,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  AppDimension.w16,
                                  SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: onTogglePlayPause,
                                      icon: Icon(
                                        isPlaying
                                            ? Iconsax.pause5
                                            : Iconsax.play5,
                                        size: 17,
                                        color: AppColor.white,
                                      ),
                                    ),
                                  ),
                                  AppDimension.w16,
                                  SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: onToggleMute,
                                      icon: Icon(
                                        isMuted
                                            ? Iconsax.volume_mute5
                                            : Iconsax.volume_high5,
                                        size: 16,
                                        color: AppColor.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  _iconButton('setting.png', onTap: () {}),
                                  AppDimension.w16,
                                  _iconButton('screen.png', onTap: () {}),
                                  AppDimension.w16,
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 53),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: .5,
                        child: Image.asset(
                          'assets/icons/upload_green.png',
                          height: 50,
                        ),
                      ),
                      AppDimension.h4,
                      customText(
                        text:
                            "Your videos will be private until you publish them",
                        fontSize: 14,
                      ),
                      AppDimension.h4,
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColor.green,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 6,
                          ),
                        ),
                        onPressed: onPickVideo,
                        child: customText(
                          text: "Upload",
                          fontSize: 14,
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
