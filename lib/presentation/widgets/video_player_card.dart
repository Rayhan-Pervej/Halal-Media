import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/utils/app_dimension.dart';

class VideoPlayerCard extends StatefulWidget {
  final String videoUrl; // YouTube video URL
  const VideoPlayerCard({super.key, required this.videoUrl});

  @override
  State<VideoPlayerCard> createState() => _VideoPlayerCardState();
}

class _VideoPlayerCardState extends State<VideoPlayerCard> {
  late YoutubePlayerController _controller;
  bool _isMuted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        
        controlsVisibleAtStart: true,
        showLiveFullscreenButton: false,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      width: 16 / 9,
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: AppColor.green,
      progressColors: ProgressBarColors(
        playedColor: AppColor.green,
        handleColor: AppColor.green,
        backgroundColor: AppColor.black400,
        bufferedColor: AppColor.black200,
      ),

      bottomActions: [
        _iconButton(
          _controller.value.isPlaying ? 'pause.png' : 'play.png',
          onTap: () {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          },
        ),
        AppDimension.w16,
        _iconButton(
          'forward.png',
          onTap: () {
            final currentPosition = _controller.value.position;
            _controller.seekTo(currentPosition + const Duration(seconds: 10));
          },
        ),
        AppDimension.w16,
        _iconButton(
          _isMuted ? 'mute.png' : 'volume.png',
          onTap: () {
            if (_isMuted) {
              _controller.unMute();
            } else {
              _controller.mute();
            }
            setState(() {
              _isMuted = !_isMuted;
            });
          },
        ),
        const Spacer(), // Push right-side buttons to the end

        _iconButton(
          'float.png',
          onTap: () {
            // Floating action
          },
        ),
        AppDimension.w16,
        _iconButton(
          'setting.png',
          onTap: () {
            // Settings action
          },
        ),
        AppDimension.w16,
        _iconButton(
          'screen.png',
          onTap: () {
            _controller.toggleFullScreenMode();
          },
        ),
      ],

      onReady: () {
        _isPlayerReady = true;
      },
      onEnded: (metaData) {
        // You can do something when the video ends
      },
    );
  }

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
}
