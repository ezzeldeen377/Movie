import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/app_provider/app_provider.dart';
import 'package:movie/pages/home_screen/movie_details/cubit/movie_details_state.dart';
import 'package:movie/pages/home_screen/movie_details/cubit/movie_details_view_model.dart';
import 'package:movie/pages/home_screen/widgets/video_details.dart';
import 'package:movie/pages/home_screen/widgets/video_widget.dart';
import 'package:provider/provider.dart';

class VideoSliderWidget extends StatelessWidget {
  String movieId;
  VideoSliderWidget({required this.movieId});
  MovieDetailsViewModel viewModel=MovieDetailsViewModel();


  @override
  Widget build(BuildContext context) {


    var pro=Provider.of<AppProvider>(context);

    AppProvider provider=AppProvider(appLanguage:pro.appLanguage);
    viewModel.getMovieVideos(movieId, provider.appLanguage);
    return BlocBuilder<MovieDetailsViewModel,MovieDetailsState>(
      bloc: viewModel,
      builder: (context,state){

          if(state is MovieVideoLoadingState){
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.whiteColor,
              size: 50,
            ),
          );
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
            color: AppColors.darkGrayColor,
            child: CarouselSlider.builder(
                  itemCount: state.videoList.length,
                  options: CarouselOptions(
                    // Adjust height based on screen size
                    autoPlay: false,
                    height: 300,
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
                        Expanded(child: VideoWidget(video: state.videoList[index])),
                        VideoDetails(video: state.videoList[index])

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
