import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/pages/browse/CategoryPhoto.dart';
import 'package:movie/pages/browse/Movies/Cubit/MovieState.dart';
import 'package:movie/pages/browse/Movies/Cubit/Movie_details_viewModel.dart';
import 'package:movie/pages/home_screen/widgets/movie_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../app_colors.dart';

class Moviespage extends StatefulWidget {
  static const String routeName = "Moviespage";
  final Category category;
  Moviespage({required this.category});

  @override
  State<Moviespage> createState() => _MoviespageState();
}

class _MoviespageState extends State<Moviespage> {
  MovieDetailsVeiwmodel viewModel = MovieDetailsVeiwmodel();

  @override
  void initState() {
    super.initState();
    viewModel.getMoives(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category.name ?? "",
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
                        Text('${AppLocalizations.of(context)!.some} ${state.errorMessage}'),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(AppLocalizations.of(context)!.try_again),
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
                          viewModel.getMoives(widget.category.id,
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
                                crossAxisSpacing: 30,
                                mainAxisSpacing: 30,
                                    childAspectRatio: .58
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
                              return Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.whiteColor));
                            } else {}
                            return SizedBox.shrink();
                          })
                        ],
                      ));
                }
                return Center(
                    child: Text(
                  AppLocalizations.of(context)!.no,
                  style: TextStyle(color: AppColors.whiteColor),
                ));
              }),
        ));
  }
}
