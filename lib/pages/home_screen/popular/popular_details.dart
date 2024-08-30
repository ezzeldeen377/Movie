import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/pages/home_screen/popular/cubit/popular_state.dart';
import 'package:movie/pages/home_screen/popular/popular_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../app_colors.dart';
import 'cubit/popular_details_view_model.dart';

class PopularDetails extends StatefulWidget {
  @override
  State<PopularDetails> createState() => _PopularDetailsState();
}

class _PopularDetailsState extends State<PopularDetails> {
  PopularDetailsViewModel viewModel = PopularDetailsViewModel();

  @override
  void initState() {
    // TODO: implement initState
    viewModel.getPopular();
  }

  @override
  Widget build(BuildContext context) {
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
                Text( '${AppLocalizations.of(context)!.some}''${state.errorMessage}'),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(AppLocalizations.of(context)!.try_again),
                ),
              ],
            ),
          );
        } else if (state is PopularSuccessState) {
          return PopularWidget(popularList: state.popularList);
        }
        return Text(AppLocalizations.of(context)!.no);
      }),
    );
  }
}
