import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../app_colors.dart';
import 'cubit/more_like_this_state.dart';
import 'cubit/more_like_this_view_model.dart';
import 'more_like_this_widget.dart';

class MoreLikeThisLogic extends StatefulWidget {
  String id;

  MoreLikeThisLogic({required this.id});

  @override
  State<MoreLikeThisLogic> createState() => _MoreLikeThisLogicState();
}

class _MoreLikeThisLogicState extends State<MoreLikeThisLogic> {
  MoreLikeThisViewModel viewModel = MoreLikeThisViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getMoreLike(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<MoreLikeThisViewModel, MoreLikeState>(
          builder: (context, state) {
        if (state is MoreLikeLoadingState) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.whiteColor,
              size: 50,
            ),
          );
        } else if (state is MoreLikeErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Something went wrong: ${state.errorMessage}',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Try Again'),
                ),
              ],
            ),
          );
        } else if (state is MoreLikeStateSuccessState) {
          return MoreLikeUi(moreLike: state.moreLike);
        }
        return Text('noooooooo');
      }),
    );
  }
}
