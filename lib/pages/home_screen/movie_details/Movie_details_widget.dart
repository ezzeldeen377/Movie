import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../api/api_constant.dart';
import '../model/movieDetails.dart';
import 'more_like.dart';
import 'movie_Info.dart';
import 'movie_cast.dart';
import 'movie_videoSlider.dart';

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
            SizedBox(height: 16),
            MovieVideoSlider(movieId: movie.id.toString()),
            MovieInfo(
              title: movie.title ?? "Title Not Available",
              releaseDate: movie.releaseDate,
              overview: movie.overview ?? 'Description not available.',
              posterUrl: fullImageUrl,
              popularity: movie.popularity.toString(),
              language: movie.originalLanguage.toString(),
              runtime: movie.runtime.toString(),
              revenue: movie.revenue.toString(),
              voteAverage: movie.voteAverage,
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
