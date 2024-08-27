import 'package:flutter/material.dart';
import 'package:movie/pages/home_screen/widgets/video_slider_widget.dart';

class MovieVideoSlider extends StatelessWidget {
  final String movieId;

  MovieVideoSlider({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Container(
        child: VideoSliderWidget(movieId: movieId),
      ),
    );
  }
}
