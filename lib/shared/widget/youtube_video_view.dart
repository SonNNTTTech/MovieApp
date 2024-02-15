import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeVideoView extends StatefulWidget {
  final String id;
  const YoutubeVideoView({
    super.key,
    required this.id,
  });

  @override
  State<YoutubeVideoView> createState() => _YoutubeVideoViewState();
}

class _YoutubeVideoViewState extends State<YoutubeVideoView>
    with AutomaticKeepAliveClientMixin {
  final _controller = YoutubePlayerController(
    params: const YoutubePlayerParams(
      mute: false,
      showControls: true,
      showFullscreenButton: true,
    ),
  );
  @override
  void initState() {
    _controller.cueVideoById(videoId: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return YoutubePlayer(
      controller: _controller,
      aspectRatio: 16 / 9,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
