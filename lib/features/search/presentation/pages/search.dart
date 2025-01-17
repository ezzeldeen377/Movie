import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/app_provider/app_provider.dart';
import 'package:movie/core/di/di.dart';
import 'package:movie/features/search/presentation/bloc/search_view_model.dart';
import 'package:movie/features/search/presentation/bloc/search_state.dart';
import 'package:movie/features/search/presentation/widgets/result_Item.dart';
import 'package:movie/features/search/presentation/widgets/search_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Search extends StatelessWidget {
  Search({super.key});
  final TextEditingController searchController = TextEditingController();
  final Debouncer debouncer = Debouncer();
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<AppProvider>(context);
    return BlocProvider(
      create: (context) => getIt<SearchViewModel>(),
      child: BlocBuilder<SearchViewModel, SearchState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchField(
                    searchController: searchController,
                    onChanged: (query) {
                      debouncer.debounce(
                          duration: const Duration(milliseconds: 800),
                          onDebounce: () {
                            context
                                .read<SearchViewModel>()
                                .search(query, pro.appLanguage);
                          });
                    },
                    onPreesd: () {
                      searchController.clear();
                      context.read<SearchViewModel>().clear();
                    },
                  ),
                  BlocBuilder<SearchViewModel, SearchState>(
                    builder: (context, state) {
                      if (state.isLoaded) {
                        if (state.movieResult.isNotEmpty) {
                          return Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                thickness: 3,
                                color: AppColors.darkGrayColor,
                                endIndent:
                                    MediaQuery.of(context).size.width * 0.1,
                                indent: MediaQuery.of(context).size.width * 0.1,
                              ),
                              itemCount: state.movieResult.length,
                              itemBuilder: (context, index) {
                                return ResultItem(
                                    movie: state.movieResult[index]);
                              },
                            ),
                          );
                        }
                      } else if (state.isLoading) {
                        return Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: AppColors.whiteColor,
                            size: 50,
                          ),
                        );
                      } else if (state.isError) {
                        return Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  const AssetImage(
                                      'assets/icons/icon_background.png'),
                                  color: AppColors.whiteColor,
                                  size: 50,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.errorMessage!,
                                  style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (state.isInitial) {
                        return Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  const AssetImage(
                                      'assets/icons/icon_background.png'),
                                  color: AppColors.whiteColor,
                                  size: 50,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  AppLocalizations.of(context)!
                                      .search_on_any_movie,
                                  style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
