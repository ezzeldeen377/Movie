import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_provider/app_provider.dart';
import 'package:movie/pages/home_screen/recommended/cubit/recommended_details_view_model.dart';
import 'package:movie/pages/home_screen/recommended/cubit/recommended_state.dart';
import 'package:movie/pages/home_screen/widgets/movie_item.dart';
import 'package:provider/provider.dart';

import '../../../app_colors.dart';

class RecommendeDetails extends StatelessWidget {
  RecommendedDetailsViewModel viewModel = RecommendedDetailsViewModel();
  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<AppProvider>(context);
    AppProvider provider=AppProvider(appLanguage:pro.appLanguage);
    viewModel.getRecommended(provider.appLanguage);
    return BlocProvider(
      create: (context)=>viewModel,
      child: BlocBuilder<RecommendedDetailsViewModel, RecommendedState>(
          buildWhen: (previous, current) => current is !RecommendedPaginationState,
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
              return NotificationListener<ScrollNotification>(
                  onNotification: (notification){

                    if(notification.metrics.pixels==notification.metrics.maxScrollExtent&&notification is ScrollUpdateNotification){
                      viewModel.getRecommended(provider.appLanguage,fromPagination: true);
                    }
                    return true ;
                  },child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.recommendedList.length,
                        itemBuilder: (context, index) {
                          return MovieItem(movie: state.recommendedList[index]);
                        }
                    ),
                  ),
                  BlocBuilder<RecommendedDetailsViewModel, RecommendedState>(
                      builder: (context, state) {
                        if(state is RecommendedPaginationState) {
                          return SafeArea(
                            child: Center(child: CircularProgressIndicator(
                                color: AppColors.yellowColor)),
                          );
                        }else{

                        }
                        return SizedBox.shrink();   }
                  )
                ],
              )
              );
            }
            return Center(child: Text('noooooooo',style: TextStyle(color: AppColors.whiteColor),));
          }),
    );
  }
}
