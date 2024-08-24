import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../api/api_manager.dart';
import '../model/movieDetails.dart';
import '../../../app_colors.dart';
import 'Movie_details_Ui.dart';
import 'cubit/movie_details_state.dart';
import 'cubit/movie_details_view_model.dart';

class MovieDetailsLogic extends StatefulWidget {
  final String movieId;

  MovieDetailsLogic({required this.movieId});

  @override
  State<MovieDetailsLogic> createState() => _MovieDetailsLogicState();
}

class _MovieDetailsLogicState extends State<MovieDetailsLogic> {
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
              return MovieDetailsUI(movie: state.movieDetail);
            }
            return Text('noooooooo');
          }),
    );
  }
}
