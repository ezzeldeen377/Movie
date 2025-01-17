import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/app_provider/app_provider.dart';
import 'package:movie/features/home_screen/data/models/movie_response.dart';
import 'package:movie/features/home_screen/presentation/bloc/home_screen/home_screen_state.dart';
import 'package:movie/features/home_screen/presentation/bloc/home_screen/home_screen_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie/features/home_screen/presentation/widgets/home_screen/movie_item.dart';

class NewReleasesMoviesSection extends StatelessWidget {
  const NewReleasesMoviesSection({required this.newReleasesMovies,super.key});
  final List<Movie> newReleasesMovies;
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
              AppLocalizations.of(context)!.new_releases,
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
                    context.read<HomeScreenViewModel>().getNewReleases(
                         context.read<AppProvider>().appLanguage,
                        fromPagination: true);
                  }
                  return true;
                },
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: newReleasesMovies.length,
                          itemBuilder: (context, index) {
                            return MovieItem(
                                movie:newReleasesMovies[index]);
                          }),
                    ),
                    BlocBuilder<HomeScreenViewModel, HomeScreenState>(
                        builder: (context, state) {
                      if (state.isNewReleasesPagination) {
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
