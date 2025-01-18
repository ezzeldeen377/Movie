import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/features/home_screen/data/models/movieDetails.dart';
import 'package:movie/features/home_screen/presentation/bloc/movie_details/movie_details_view_model.dart';
import 'package:movie/features/home_screen/presentation/widgets/movie_details/more_like_this_movies_section.dart';
import 'package:movie/features/home_screen/presentation/widgets/movie_details/cast_widget.dart';
import 'package:movie/features/home_screen/presentation/widgets/movie_details/movie_info.dart';
import 'package:movie/features/home_screen/presentation/widgets/movie_details/video_slider_widget.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MovieDetailsWidget extends StatelessWidget {
  final MovieDetails movie;

  const MovieDetailsWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VideoSliderWidget(movieId: movie.id.toString()),
        MovieInfo(
          movie: movie,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            AppLocalizations.of(context)!.cast,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        SizedBox(height: 150.h, child: CastWidget(credits: movie.credits!)),
        SizedBox(
            height: 320.h,
            child: MoreLikeThisMoviesSection(
              movieId: movie.id.toString(),
              moreLikeThisMovies:
                  context.read<MovieDetailsViewModel>().state.movieList ??
                      [],
            )),
        const SizedBox(height: 15),
      ],
    ));
  }
}
