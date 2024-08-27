import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/pages/home_screen/recommended/cubit/recommended_details_view_model.dart';
import 'package:movie/pages/home_screen/recommended/cubit/recommended_state.dart';
import 'package:movie/pages/home_screen/recommended/recommended_widget.dart';

import '../../../app_colors.dart';

class RecommendeDetails extends StatefulWidget {
  @override
  State<RecommendeDetails> createState() => _RecommendeDetailsState();
}

class _RecommendeDetailsState extends State<RecommendeDetails> {
  RecommendedDetailsViewModel viewModel = RecommendedDetailsViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getRecommended();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<RecommendedDetailsViewModel, RecommendedState>(
          builder: (context, state) {
        if (state is RecommendedLoadingState) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.whiteColor,
              size: 50,
            ),
          );
        } else if (state is RecommendedErrorState) {
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
        } else if (state is RecommendedSuccessState) {
          return RecommendedWidget(recommendedList: state.recommendedList);
        }
        return Text('noooooooo');
      }),
    );
  }
}
