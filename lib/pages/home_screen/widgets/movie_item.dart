import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/pages/watch_list/cubit/movies_state.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_view_model.dart';
import 'package:movie/pages/watch_list/widgets/book_mark_widget.dart';

import '../../../../app_colors.dart';
import '../api/api_constant.dart';
import '../model/movie_response.dart';
import '../movie_details/movie_details_view.dart';

class MovieItem extends StatefulWidget {
  final Movie movie;

  MovieItem({required this.movie});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final posterPath = widget.movie.posterPath?.startsWith('/') ?? false
        ? widget.movie.posterPath!.substring(1)
        : widget.movie.posterPath ?? "";
    final fullImageUrl = ApiConstant.imageUrl + posterPath;

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
        width: 130,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.forGroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: CachedNetworkImage(
                    imageUrl: fullImageUrl,
                    width: double.infinity,
                    height: 170,
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
                Positioned(
                  top: -6,
                  left: -7,
                  child: BookMarkWidget(
                    movie: widget.movie,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Text(
                widget.movie.title ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              child: Text(
                widget.movie.releaseDate ?? "",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 13, fontWeight: FontWeight.normal),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/icons/star_icon.png'),
                    color: AppColors.yellowColor,
                  ),
                  SizedBox(width: 7),
                  Text(
                    widget.movie.voteAverage?.toStringAsFixed(1) ?? 'N/A',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
