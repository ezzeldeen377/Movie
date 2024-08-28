import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/pages/browse/Models/MovieResponse.dart';
import 'package:movie/pages/watch_list/cubit/movies_state.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_navigetor.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_view_model.dart';

import '../../../../app_colors.dart';
import '../home_screen/api/api_constant.dart';
import '../home_screen/movie_details/movie_details_view.dart';

class MovieItem extends StatefulWidget {
  final Movie movie;

  MovieItem({required this.movie});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> implements WatchListNagvigetor {
  WatchListViewModel viewModel = WatchListViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.nagvigetor = this;
    viewModel.getAllMoviesFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    final posterPath = widget.movie.posterPath?.startsWith('/') ?? false
        ? widget.movie.posterPath!.substring(1)
        : widget.movie.posterPath ?? "";
    final fullImageUrl = ApiConstant.imageUrl + posterPath;

    return BlocBuilder<WatchListViewModel, MoviesState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is SuccessState) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsView(
                    movieId: widget.movie.id.toString(),
                  ),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              margin: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.darkGrayColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        child: CachedNetworkImage(
                          imageUrl: fullImageUrl,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width * 0.30,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: AppColors.whiteColor,
                              size: 50,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      widget.movie.title ?? "",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is ErrorState) {
          return Text('Something Went Wrong');
        } else if (state is LoadingState) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.whiteColor,
              size: 50,
            ),
          ));
        }
        return Container();
      },
    );
  }

  @override
  showSnakeBar(String message) {
    // TODO: implement showSnakeBar
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
