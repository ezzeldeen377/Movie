import 'package:flutter/material.dart';
import 'package:movie/pages/home_screen/model/MovieVideos.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWidget extends StatefulWidget {
  late Video video;
  VideoWidget({required this.video});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.key??'', // Using the passed videoId
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false, // set to false to allow sound
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller properly
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,

        ),

      );

  }
}