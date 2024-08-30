import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_provider/app_provider.dart';
import 'package:movie/pages/home_screen/widgets/movie_item.dart';
import 'package:provider/provider.dart';

import '../../../app_colors.dart';
import 'cubit/more_like_this_state.dart';
import 'cubit/more_like_this_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MoreLikeThisDetailsView extends StatelessWidget {
  String id;

  MoreLikeThisDetailsView({required this.id});

  MoreLikeThisViewModel viewModel = MoreLikeThisViewModel();

  @override


  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<AppProvider>(context);
    AppProvider provider=AppProvider(appLanguage:pro.appLanguage);
    viewModel.getMoreLike(id,provider.appLanguage);

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
                    Text(AppLocalizations.of(context)!.some +state.errorMessage),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(AppLocalizations.of(context)!.try_again),
                    ),
                  ],
                ),
              );
            } else if (state is MoreLikeThisSuccessState) {
              return NotificationListener<ScrollNotification>(
                  onNotification: (notification){

                    if(notification.metrics.pixels==notification.metrics.maxScrollExtent&&notification is ScrollUpdateNotification){
                      viewModel.getMoreLike(id,provider.appLanguage,fromPagination: true);
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
                          return SafeArea(child:Center(child: CircularProgressIndicator(
                              color: AppColors.yellowColor)));
                        }else{

                        }
                        return SizedBox.shrink();   }
                  )
                ],
              )
              );
            }
            return Center(child: Text(AppLocalizations.of(context)!.empty,style: TextStyle(color: AppColors.whiteColor),));
          }),
    );
  }
}
