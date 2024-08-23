import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_screen/new_releases/cubit/releases_state.dart';
import 'package:movie/pages/home_screen/new_releases/releases_widget.dart';
import '../../../app_colors.dart';

import 'cubit/releases_details_view_model.dart';

class ReleasesDetails extends StatefulWidget {
  @override
  State<ReleasesDetails> createState() => _ReleasesDetailsState();
}

class _ReleasesDetailsState extends State<ReleasesDetails> {
  ReleasesDetailsViewModel viewModel = ReleasesDetailsViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getReleases();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<ReleasesDetailsViewModel, ReleasesState>(
          builder: (context, state) {
        if (state is ReleasesLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.whiteColor,
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
          return ReleasesWidget(releasesList: state.releasesList);
        }
        return Text('noooooooo');
      }),
    );
  }
}
