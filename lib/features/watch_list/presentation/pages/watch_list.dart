import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/features/watch_list/presentation/bloc/movies_state.dart';
import 'package:movie/features/watch_list/presentation/bloc/watch_list_view_model.dart';
import 'package:movie/features/watch_list/presentation/widgets/watch_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<WatchListViewModel>();
    return Container(
      color: AppColors.blackColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    AppLocalizations.of(context)!.watch_list,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton.icon(
                    label: Text(AppLocalizations.of(context)!.delete_all),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellowColor,
                        foregroundColor: AppColors.backgroundColor,
                        padding: const EdgeInsets.symmetric(horizontal: 10)),
                    onPressed: () {
                      viewModel.deleteAllFromFireStore();
                    },
                    icon: const Icon(Icons.delete),
                  ),
                )
              ],
            ),
            BlocBuilder<WatchListViewModel, WatchListState>(
                builder: (context, state) {
              final movies = state.movies ?? [];
              if (state.isLoading) {
                return Expanded(
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.whiteColor,
                      size: 50,
                    ),
                  ),
                );
              } else if (state.isError) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ImageIcon(
                        const AssetImage('assets/icons/no_data_icon.png'),
                        size: 100,
                        color: AppColors.whiteColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        state.errorMessage!,
                        style: TextStyle(color: AppColors.whiteColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }  else if (state.isLoaded ||state.isFinish) {
                if (movies.isNotEmpty) {
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        thickness: 3,
                        color: AppColors.darkGrayColor,
                        endIndent: MediaQuery.of(context).size.width * 0.1,
                        indent: MediaQuery.of(context).size.width * 0.1,
                      ),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(15),
                        child: WatchItem(
                          movie: state.movies![index],
                        ),
                      ),
                      itemCount: state.movies!.length,
                    ),
                  );
                } else {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ImageIcon(
                          const AssetImage('assets/icons/no_data_icon.png'),
                          size: 100,
                          color: AppColors.whiteColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.no_movie_to_show,
                          style: TextStyle(color: AppColors.whiteColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
