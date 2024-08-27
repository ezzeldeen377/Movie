import 'package:flutter/material.dart';
import 'package:movie/pages/home_screen/model/movieDetails.dart';
import 'package:movie/pages/home_screen/widgets/video_slider_widget.dart';

import '../../../app_colors.dart';
import '../api/api_constant.dart';
import 'more_like.dart';
import 'movie_Info.dart';
import 'movie_cast.dart';

class MovieDetailsWidget extends StatelessWidget {
  final MovieDetails movie;

  MovieDetailsWidget({required this.movie});

  @override
  Widget build(BuildContext context) {
    final fullImageUrl = ApiConstant.imageUrl + (movie.posterPath ?? "");

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          movie.title ?? 'Movie Details',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        iconTheme: IconThemeData(color: AppColors.whiteColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(

                child:VideoSliderWidget(movieId: movie.id.toString())
            ),
            MovieInfo(movie: movie,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Cast',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            MovieCast(credits: movie.credits),
            SizedBox(height: 16),
            MoreLikeThis(movieId: movie.id.toString()),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
