import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/api/api_constants.dart';
import 'package:movie/core/theme/app_colors.dart';
import 'package:movie/features/home_screen/data/models/movie_response.dart';
import 'package:movie/features/watch_list/presentation/widgets/book_mark_widget.dart';

import '../../pages/movie_details_view.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  @override
  Widget build(BuildContext context) {
    // Create the full image URL based on the current movie
    final posterPath = widget.movie.posterPath?.startsWith('/') ?? false
        ? widget.movie.posterPath!.substring(1)
        : widget.movie.posterPath ?? "";
    final fullImageUrl = ApiConstants.imageUrl + posterPath;

    final posterBackDropPath = widget.movie.backdropPath ?? "";
    final fullImageUrl2 = ApiConstants.imageUrl + posterBackDropPath;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsView(
              movieId: widget.movie.id.toString(),
              movieName: widget.movie.title ?? "",
            ),
          ),
        );
      },
      child: Stack(alignment: Alignment.topRight, children: [
        // Main image
        Stack(alignment: Alignment.center, children: [
          CachedNetworkImage(
            imageUrl: fullImageUrl2,
            width: double.infinity,
            height: 230.h,
            fit: BoxFit.fill,
          ),
          Icon(
            Icons.play_circle_filled,
            color: AppColors.whiteColor,
            size: 50.h, // Adjust size
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
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: CachedNetworkImage(
                      imageUrl:
                          fullImageUrl, // Use different image URL if needed
                      fit: BoxFit.fill,
                      width: 100.w,
                      height: 150.h,
                    ),
                  ),
                  Positioned(
                      top: -6,
                      left: -7,
                      child: BookMarkWidget(
                        movie: widget.movie,
                      ))
                ],
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.movie.title ?? 'No title',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 20.h),
                        softWrap: true,
                        textAlign: TextAlign.start,
                        maxLines: 2, // Limits the title to 2 lines
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Release Date: ${widget.movie.releaseDate ?? 'No date'}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontSize: 20.h),
                        softWrap: true,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ]),
    );
  }
}
