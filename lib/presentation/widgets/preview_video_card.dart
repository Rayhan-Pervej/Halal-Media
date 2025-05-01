import 'dart:io';

import 'package:flutter/material.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:video_player/video_player.dart';

class PreViewVideoPlayer extends StatefulWidget {
  final String videoPath;
  const PreViewVideoPlayer({super.key, required this.videoPath});

  @override
  State<PreViewVideoPlayer> createState() => _PreViewVideoPlayerState();
}

class _PreViewVideoPlayerState extends State<PreViewVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : AspectRatio(
                aspectRatio: 4 / 2.3,
                child: Image.asset(
                  "assets/thumbnails/video_load.png",
                  fit: BoxFit.cover,
                ),
              ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            children: [
              VideoProgressIndicator(
                _controller,
                allowScrubbing: true,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
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
                      _controller.value.isPlaying
                          ? IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: Image.asset(
                                'assets/icons/video_player/pause.png',
                                height: 16,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller.pause();
                                });
                              },
                            )
                          : IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: Image.asset(
                                'assets/icons/video_player/play.png',
                                height: 16,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller.play();
                                });
                              },
                            ),
                      AppDimension.w16,
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Image.asset(
                          'assets/icons/video_player/forward.png',
                          height: 16,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            final pos = _controller.value.position;
                            _controller.seekTo(pos + const Duration(seconds: 10));
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Image.asset(
                          'assets/icons/video_player/setting.png',
                          height: 16,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Future settings
                        },
                      ),
                      AppDimension.w16,
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Image.asset(
                          'assets/icons/video_player/screen.png',
                          height: 16,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Fullscreen toggle logic
                        },
                      ),
                      AppDimension.w16,
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}