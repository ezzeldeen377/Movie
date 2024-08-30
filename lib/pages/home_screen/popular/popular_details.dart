import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_provider/app_provider.dart';
import 'package:movie/pages/home_screen/popular/cubit/popular_state.dart';
import 'package:movie/pages/home_screen/popular/movie_carousel.dart';
import 'package:provider/provider.dart';

import '../../../app_colors.dart';
import 'cubit/popular_details_view_model.dart';

class PopularDetails extends StatelessWidget {
  PopularDetailsViewModel viewModel = PopularDetailsViewModel();



  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<AppProvider>(context);
    AppProvider provider=AppProvider(appLanguage:pro.appLanguage);
    viewModel.getPopular(provider.appLanguage);

    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<PopularDetailsViewModel, PopularState>(
          builder: (context, state) {
        if (state is PopularLoadingState) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.whiteColor,
              size: 50,
            ),
          );
        } else if (state is PopularErrorState) {
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
        } else if (state is PopularSuccessState) {
          return MovieCarousel(popularList: state.popularList);
        }
        return Text('noooooooo');
      }),
    );
  }
}
