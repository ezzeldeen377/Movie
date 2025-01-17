import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/app_provider/app_provider.dart';
import 'package:movie/features/home_screen/presentation/bloc/movie_details/movie_details_state.dart';
import 'package:movie/features/home_screen/presentation/bloc/movie_details/movie_details_view_model.dart';
import 'package:movie/features/home_screen/presentation/widgets/video_details.dart';
import 'package:movie/features/home_screen/presentation/widgets/video_widget.dart';
import 'package:provider/provider.dart';

class VideoSliderWidget extends StatelessWidget {
  final String movieId;
  const VideoSliderWidget({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsViewModel, MovieDetailsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.whiteColor,
              size: 50,
            ),
          );
        } else if (state.isError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Something went wrong: ${state.errorMessage}',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        } else if (state.videos != null) {
          return CarouselSlider.builder(
              itemCount: state.videos?.length,
              options: CarouselOptions(
                height: 300,
                viewportFraction: 1,
                enlargeCenterPage: true,
              ),
              itemBuilder: (context, index, realIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: VideoWidget(video: state.videos![index])),
                    VideoDetails(video: state.videos![index])
                  ],
                );
              });
        }
        return Text(
          '${state.status.name}',
          style: TextStyle(color: AppColors.whiteColor),
        );
      },
    );
  }
}
