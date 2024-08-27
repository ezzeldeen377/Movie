import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/watch_list/cubit/movies_state.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_navigetor.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_view_model.dart';
import 'package:movie/pages/watch_list/widgets/book_mark_widget.dart';

import '../api/api_constant.dart';
import '../model/movie_response.dart';
import '../movie_details/movie_details_view.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  final double screenWidth;
  final double screenHeight;

  MovieCard({
    required this.movie,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> implements WatchListNagvigetor {
  WatchListViewModel viewModel =WatchListViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.nagvigetor=this;
    viewModel.getAllMoviesFromFireStore();
  }
  @override
  Widget build(BuildContext context) {
    // Create the full image URL based on the current movie
    final posterPath = widget.movie.posterPath?.startsWith('/') ?? false
        ? widget.movie.posterPath!.substring(1)
        : widget.movie.posterPath ?? "";
    final fullImageUrl = ApiConstant.imageUrl + posterPath;

    final posterBackDropPath = widget.movie.backdropPath ?? "";
    final fullImageUrl2 = ApiConstant.imageUrl + posterBackDropPath;

    return BlocBuilder<WatchListViewModel,MoviesState>(
      bloc: viewModel,
      builder: (context,state){
        if(state is SuccessState) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MovieDetailsView(
                        movieId: widget.movie.id.toString(),
                      ),
                ),
              );
            },
            child: Stack(alignment: Alignment.topRight, children: [
              // Main image
              Stack(alignment: Alignment.center, children: [
                Image.network(
                  fullImageUrl2,
                  width: double.infinity,
                  height: widget.screenHeight * 0.30,
                  fit: BoxFit.fill,
                ),
                Icon(
                  Icons.play_circle_filled,
                  color: AppColors.whiteColor,
                  size: widget.screenWidth * 0.17, // Adjust size
                ),
              ]),
              // Play icon positioned at the center of the large image

              // Overlay image positioned at the bottom
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
              topRight: Radius.circular(15)
          ),
                        child: Image.network(
                          fullImageUrl, // Use different image URL if needed
                          fit: BoxFit.fill,
                          width: widget.screenWidth * 0.35,
                          height: widget.screenHeight * 0.25,
                        ),
                      ),
                      Positioned(
                          top: -6,
                          left: -7,
                          child: BookMarkWidget(
                              viewModel: viewModel, movie: Movie.fromJson(widget
                              .movie.toJson()),isBooked:state.movieList.any((movieSaved){
                            return movieSaved.id==widget.movie.id;
                          })))
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: widget.screenWidth * .6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              widget.movie.title ?? 'No title',
                              style: TextStyle(
                                fontSize: widget.screenWidth * 0.05,
                                // Adjust font size
                                fontWeight: FontWeight.bold,
                                color: AppColors.whiteColor,
                              ),
                              softWrap: true,
                              textAlign: TextAlign.start,
                              maxLines: 2, // Limits the title to 2 lines
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Release Date: ${widget.movie.releaseDate ??
                                  'No date'}',
                              style: TextStyle(
                                fontSize: widget.screenWidth * 0.04,
                                // Adjust font size
                                color: Colors.grey[600],
                              ),
                              softWrap: true,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ]),
          );
        }else if (state is ErrorState){
          return Text('Something Went Wrong');
        }
        else if(state is LoadingState){
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
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );
  }
}
