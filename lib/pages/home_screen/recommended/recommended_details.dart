import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/pages/home_screen/recommended/cubit/recommended_details_view_model.dart';
import 'package:movie/pages/home_screen/recommended/cubit/recommended_state.dart';
import 'package:movie/pages/home_screen/recommended/recommended_widget.dart';
import 'package:movie/pages/home_screen/widgets/movie_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                    Text('${AppLocalizations.of(context)!.some}'' ${state.errorMessage}'),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(AppLocalizations.of(context)!.no),
                    ),
                  ],
                ),
              );
            } else if (state is RecommendedSuccessState) {
              return NotificationListener<ScrollNotification>(
                  onNotification: (notification){

                    if(notification.metrics.pixels==notification.metrics.maxScrollExtent&&notification is ScrollUpdateNotification){
                      viewModel.getRecommended(fromPagination: true);
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
                          return Center(child: CircularProgressIndicator(
                              color: AppColors.whiteColor));
                        }else{

                        }
                        return SizedBox.shrink();   }
                  )
                ],
              )
              );
            }
            return Center(child: Text(AppLocalizations.of(context)!.no,style: TextStyle(color: AppColors.whiteColor),));
          }),
    );
  }
}
