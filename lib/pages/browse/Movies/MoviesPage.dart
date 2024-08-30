import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/pages/browse/CategoryPhoto.dart';
import 'package:movie/pages/browse/Movies/Cubit/MovieState.dart';
import 'package:movie/pages/browse/Movies/Cubit/Movie_details_viewModel.dart';
import 'package:movie/pages/home_screen/widgets/movie_item.dart';
import 'package:provider/provider.dart';


import '../../../app_colors.dart';
import '../../../app_provider/app_provider.dart';

class Moviespage extends StatelessWidget {
  static const String routeName = "Moviespage";
  final Category category;
  Moviespage({required this.category});

  MovieDetailsVeiwmodel viewModel = MovieDetailsVeiwmodel();

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<AppProvider>(context);
    AppProvider provider=AppProvider(appLanguage:pro.appLanguage);
    viewModel.getMoives(category.id,provider.appLanguage);

    return Scaffold(
        appBar: AppBar(
          title: Text(category.name ?? "",
              style: TextStyle(color: Colors.white)),
        ),
        body: BlocProvider(
          create: (context) => viewModel,
          child: BlocBuilder<MovieDetailsVeiwmodel, Moviestate>(
              buildWhen: (previous, current) =>
                  current is! PaginationMovieState,
              builder: (context, state) {
                if (state is LoadingMovieState) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.whiteColor,
                      size: 50,
                    ),
                  );
                } else if (state is ErrorMovieState) {
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
                } else if (state is SuccessMovieState) {
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
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 30,
                                    childAspectRatio: .55
                              ),
                              itemBuilder: (context, index) {
                                return MovieItem(movie: state.movieList[index]);
                              },
                              itemCount: state.movieList.length,
                            ),
                          ),
                          BlocBuilder<MovieDetailsVeiwmodel, Moviestate>(
                              builder: (context, state) {
                            if (state is PaginationMovieState) {
                              return SafeArea(
                                child: Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.yellowColor)),
                              );
                            } else {}
                            return SizedBox.shrink();
                          })
                        ],
                      ));
                }
                return Center(
                    child: Text(
                  'noooooooo',
                  style: TextStyle(color: AppColors.whiteColor),
                ));
              }),
        ));
  }
}
