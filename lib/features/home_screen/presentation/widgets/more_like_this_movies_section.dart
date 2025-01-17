import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/app_provider/app_provider.dart';
import 'package:movie/features/home_screen/data/models/movie_response.dart';
import 'package:movie/features/home_screen/presentation/bloc/movie_details/movie_details_state.dart';
import 'package:movie/features/home_screen/presentation/bloc/movie_details/movie_details_view_model.dart';
import 'package:movie/features/home_screen/presentation/widgets/home_screen/movie_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoreLikeThisMoviesSection extends StatelessWidget {
  const MoreLikeThisMoviesSection(
      {required this.moreLikeThisMovies, super.key, required this.movieId});
  final List<Movie> moreLikeThisMovies;
  final String movieId;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.more,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SizedBox(
            height: 263.h,
            child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels ==
                          notification.metrics.maxScrollExtent &&
                      notification is ScrollUpdateNotification) {
                    context.read<MovieDetailsViewModel>().getMoreLike(
                        movieId,
                        fromPagination: true,
                        context.read<AppProvider>().appLanguage);
                  }
                  return true;
                },
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: moreLikeThisMovies.length,
                          itemBuilder: (context, index) {
                            return MovieItem(movie: moreLikeThisMovies[index]);
                          }),
                    ),
                    BlocBuilder<MovieDetailsViewModel, MovieDetailsState>(
                        builder: (context, state) {
                      if (state.isPagination) {
                        return SafeArea(
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.yellowColor)),
                        );
                      } else {}
                      return const SizedBox.shrink();
                    })
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
