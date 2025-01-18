import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/core/theme/app_colors.dart';
import 'package:movie/core/common/app_provider/app_cubit.dart';
import 'package:movie/core/di/di.dart';
import 'package:movie/features/home_screen/presentation/widgets/movie_details/movie_details_widget.dart';
import 'package:movie/features/home_screen/presentation/bloc/movie_details/movie_details_state.dart';
import 'package:movie/features/home_screen/presentation/bloc/movie_details/movie_details_view_model.dart';

class MovieDetailsView extends StatelessWidget {
  final String movieId;
  final String movieName;
  const MovieDetailsView(
      {super.key, required this.movieId, required this.movieName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider( 
      create: (context) => getIt<MovieDetailsViewModel>()
        ..getMovieDetail(movieId, context.read<AppCubit>().state)
        ..getMovieVideos(movieId, context.read<AppCubit>().state)
        ..getMoreLike(movieId, context.read<AppCubit>().state),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              movieName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          body: BlocBuilder<MovieDetailsViewModel, MovieDetailsState>(
              builder: (context, state) {
            if (!state.isAllDataLoaded) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.whiteColor,
                  size: 50.h,
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
                      onPressed: () {
                        context.read<MovieDetailsViewModel>().getMovieDetail(
                            movieId, context.read<AppCubit>().state);
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }
            return MovieDetailsWidget(movie: state.movieDetail!);
          })),
    );
  }
}
