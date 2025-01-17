import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/features/browse/presentation/bloc/browse_state.dart';
import 'package:movie/features/browse/presentation/bloc/browse_view_model.dart';
import 'package:movie/features/browse/presentation/widgets/CategoryPhoto.dart';
import 'package:movie/features/home_screen/presentation/widgets/home_screen/movie_item.dart';
import 'package:provider/provider.dart';


import '../../../../app_colors.dart';
import '../../../../app_provider/app_provider.dart';

class Moviespage extends StatelessWidget {
  static const String routeName = "Moviespage";
  final Category category;
  const Moviespage({super.key, required this.category});
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<BrowseViewModel>();
    var pro=Provider.of<AppProvider>(context);
    AppProvider provider=AppProvider(appLanguage:pro.appLanguage);

    return Scaffold(
        appBar: AppBar(
          title: Text(category.name ?? "",
              style: const TextStyle(color: Colors.white)),
        ),
        body: BlocBuilder<BrowseViewModel, BrowseState>(
            buildWhen: (previous, current) =>
                !current.isPaginationLoading,
            builder: (context, state) {
              if (state.isLoading) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.whiteColor,
                    size: 50,
                  ),
                );
              } else if (state.isError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Something went wrong: ${state.errorMessage}'),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.getMoives(category.id,provider.appLanguage);
                        },
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                );
              } else if (state.isLoaded) {
                return NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification.metrics.pixels ==
                              notification.metrics.maxScrollExtent &&
                          notification is ScrollUpdateNotification) {
                        viewModel.getMoives(category.id,provider.appLanguage,
                            fromPagination: true);
                      }
                      return true;
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 30,
                                  childAspectRatio: 16 / 21.5
                            ),
                            itemBuilder: (context, index) {
                              return MovieItem(movie: state.movies![index]);
                            },
                            itemCount: state.movies?.length,
                          ),
                        ),
                        BlocBuilder<BrowseViewModel, BrowseState>(
                            builder: (context, state) {
                          if (state.isPaginationLoading) {
                            return SafeArea(
                              child: Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.yellowColor)),
                            );
                          } else {}
                          return const SizedBox.shrink();
                        })
                      ],
                    ));
              }
              return Center(
                  child: Text(
                'noooooooo',
                style: TextStyle(color: AppColors.whiteColor),
              ));
            }));
  }
}
