import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_provider/app_provider.dart';
import 'package:movie/pages/home_screen/new_releases/cubit/releases_state.dart';
import 'package:movie/pages/home_screen/widgets/movie_item.dart';
import 'package:provider/provider.dart';

import '../../../app_colors.dart';
import 'cubit/releases_details_view_model.dart';

class ReleasesDetailsView extends StatefulWidget {
  @override
  State<ReleasesDetailsView> createState() => _ReleasesDetailsViewState();
}

class _ReleasesDetailsViewState extends State<ReleasesDetailsView> {
  ReleasesDetailsViewModel viewModel = ReleasesDetailsViewModel();

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<AppProvider>(context);
    AppProvider provider=AppProvider(appLanguage:pro.appLanguage);
    viewModel.getReleases(provider.appLanguage);

    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<ReleasesDetailsViewModel, ReleasesState>(
          buildWhen: (previous, current) => current is! ReleasesPaginationState,
          builder: (context, state) {
            if (state is ReleasesLoadingState) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.whiteColor,
                  size: 50,
                ),
              );
            } else if (state is ReleasesErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Something went wrong: ${state.errorMessage}'),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Try Again'),
                    ),
                  ],
                ),
              );
            } else if (state is ReleasesSuccessState) {
              return NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification.metrics.pixels ==
                            notification.metrics.maxScrollExtent &&
                        notification is ScrollUpdateNotification) {
                      viewModel.getReleases(provider.appLanguage,fromPagination: true);

                    }
                    return true;
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.releasesList.length,
                            itemBuilder: (context, index) {
                              return MovieItem(
                                  movie: state.releasesList[index]);
                            }),
                      ),
                      BlocBuilder<ReleasesDetailsViewModel, ReleasesState>(
                          bloc: viewModel,
                          builder: (context, state) {
                            if (state is ReleasesPaginationState) {
                              return SafeArea(
                                child: Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.yellowColor)),
                              );
                            } else {}
                            return SizedBox.shrink();
                          })
                    ],
                  ));
            }
            return Center(
                child: Text(
              'noooooooo',
              style: TextStyle(color: AppColors.whiteColor),
            ));
          }),
    );
  }
}
