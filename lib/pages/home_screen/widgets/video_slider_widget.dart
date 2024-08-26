import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/home_screen/movie_details/cubit/movie_details_state.dart';
import 'package:movie/pages/home_screen/movie_details/cubit/movie_details_view_model.dart';
import 'package:movie/pages/home_screen/widgets/video_details.dart';
import 'package:movie/pages/home_screen/widgets/video_widget.dart';

class VideoSliderWidget extends StatefulWidget {
  String movieId;
  VideoSliderWidget({required this.movieId});

  @override
  State<VideoSliderWidget> createState() => _VideoSliderWidgetState();
}

class _VideoSliderWidgetState extends State<VideoSliderWidget> {
  MovieDetailsViewModel viewModel=MovieDetailsViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getMovieVideos(widget.movieId);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsViewModel,MovieDetailsState>(
      bloc: viewModel,
      builder: (context,state){

          if(state is MovieVideoLoadingState){
            return Center(child: CircularProgressIndicator(color: Colors.white,));
          }else if (state is MovieVideoErrorState){
            return  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Something went wrong: ${state.errorMessage}',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Try Again'),
                  ),
                ],
              ),
            );
          }else if (state is MovieVideoSuccessState){
          return Container(
            child: CarouselSlider.builder(
                  itemCount: state.videoList.length,
                  options: CarouselOptions(
                    // Adjust height based on screen size
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      // Handle page change if needed
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex:3,child: VideoWidget(video: state.videoList[index])),
                        Expanded(flex:1,child: VideoDetails(video: state.videoList[index]))

                      ],
                    );
                  }
              ),
            );
          }
         return Text("error",style: TextStyle(color: AppColors.whiteColor),);
      },

    );

  }
}
