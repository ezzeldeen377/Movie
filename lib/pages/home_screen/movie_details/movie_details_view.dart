

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/home_screen/movie_details/Movie_details_widget.dart';
import 'package:movie/pages/home_screen/movie_details/cubit/movie_details_state.dart';
import 'package:movie/pages/home_screen/movie_details/cubit/movie_details_view_model.dart';

class MovieDetailsView extends StatefulWidget {
  final String movieId;

  MovieDetailsView({required this.movieId});

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  MovieDetailsViewModel viewModel = MovieDetailsViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getMovieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<MovieDetailsViewModel, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ),
              );
            } else if (state is MovieDetailsErrorState) {
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
                      child: Text('Try Again'),
                    ),
                  ],
                ),
              );
            } else if (state is MovieDetailsSuccessState) {
              return MovieDetailsWidget(movie: state.movieDetail);
            }
            return Text('noooooooo');
          }),
    );
  }
}
