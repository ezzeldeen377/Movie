import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/watch_list/cubit/movies_state.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_view_model.dart';
import 'package:movie/pages/watch_list/widgets/book_mark_widget.dart';

import '../api/api_constant.dart';
import '../model/movie_response.dart';
import '../movie_details/movie_details_view.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;

  MovieCard({
    required this.movie,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  WatchListViewModel viewModel = WatchListViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      child: Stack(alignment: Alignment.topRight, children: [
        // Main image
        Stack(alignment: Alignment.center, children: [
          Image.network(
            fullImageUrl2,
            width: double.infinity,
            height: 230,
            fit: BoxFit.fill,
          ),
          Icon(
            Icons.play_circle_filled,
            color: AppColors.whiteColor,
            size: 50, // Adjust size
          ),
        ]),
        // Play icon positioned at the center of the large image

        // Overlay image positioned at the bottom
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Image.network(
                      fullImageUrl, // Use different image URL if needed
                      fit: BoxFit.fill,
                      width: 100,
                      height: 150,
                    ),
                  ),
                  Positioned(
                      top: -6,
                      left: -7,
                      child: BookMarkWidget(movie: widget.movie,)
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.movie.title ?? 'No title',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 20),
                          softWrap: true,
                          textAlign: TextAlign.start,
                          maxLines: 2, // Limits the title to 2 lines
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Release Date: ${widget.movie.releaseDate ?? 'No date'}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 20),
                          softWrap: true,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ]),
    );
  }
}
