import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/pages/home_screen/widgets/movie_item.dart';

import '../../../app_colors.dart';
import 'cubit/more_like_this_state.dart';
import 'cubit/more_like_this_view_model.dart';
import 'more_like_this_widget.dart';

class MoreLikeThisDetailsView extends StatefulWidget {
  String id;

  MoreLikeThisDetailsView({required this.id});

  @override
  State<MoreLikeThisDetailsView> createState() => _MoreLikeThisDetailsViewState();
}

class _MoreLikeThisDetailsViewState extends State<MoreLikeThisDetailsView> {
  MoreLikeThisViewModel viewModel = MoreLikeThisViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getMoreLike(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>viewModel,
      child: BlocBuilder<MoreLikeThisViewModel, MoreLikeState>(
          buildWhen: (previous, current) => current is !MoreLikeThisPaginationState,
          builder: (context, state) {
            if (state is MoreLikeThisLoadingState) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.whiteColor,
                  size: 50,
                ),
              );
            } else if (state is MoreLikeThisErrorState) {
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
            } else if (state is MoreLikeThisSuccessState) {
              return NotificationListener<ScrollNotification>(
                  onNotification: (notification){

                    if(notification.metrics.pixels==notification.metrics.maxScrollExtent&&notification is ScrollUpdateNotification){
                      viewModel.getMoreLike(widget.id,fromPagination: true);
                    }
                    return true ;
                  },child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.moreLike.length,
                        itemBuilder: (context, index) {
                          return MovieItem(movie: state.moreLike[index]);
                        }
                    ),
                  ),
                  BlocBuilder<MoreLikeThisViewModel, MoreLikeState>(
                    bloc: viewModel,
                      builder: (context, state) {
                        if(state is MoreLikeThisPaginationState) {
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
            return Center(child: Text('noooooooo',style: TextStyle(color: AppColors.whiteColor),));
          }),
    );
  }
}
