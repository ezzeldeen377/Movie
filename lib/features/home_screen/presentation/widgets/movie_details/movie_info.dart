import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/api/api_constants.dart';
import 'package:movie/core/theme/app_colors.dart';
import 'package:movie/features/home_screen/data/models/movieDetails.dart';
import 'package:movie/features/home_screen/data/models/movie_response.dart';
import 'package:movie/features/home_screen/presentation/widgets/movie_details/category_view_widget.dart';
import 'package:movie/features/home_screen/presentation/widgets/movie_details/read_more_widget.dart';
import 'package:movie/features/watch_list/presentation/widgets/book_mark_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MovieInfo extends StatelessWidget {
  final MovieDetails movie;

  const MovieInfo({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          movie.title!,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          AppLocalizations.of(context)!.release_data +
              (movie.releaseDate ?? ''),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      const SizedBox(height: 16),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: CachedNetworkImage(
                  imageUrl: ApiConstants.baseImageUrl +
                      movie.posterPath!, // Use different image URL if needed
                  fit: BoxFit.fill,
                  width: 150.w,
                  height: 200.h,
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                    color: AppColors.yellowColor,
                  )),
                ),
              ),
              Positioned(
                  top: -6,
                  left: -7,
                  child: BookMarkWidget(
                    movie: Movie.fromJson(movie.toJson()),
                  ))
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: movie.genres!.map((category) {
                    return CategoryViewWidget(
                        categoryName: category.name ?? "");
                  }).toList(),
                ),
                const SizedBox(height: 15),
                ReadMoreWidget(
                  overview: movie.overview,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                     Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 24.h,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      movie.voteAverage?.toStringAsFixed(1) ?? 'N/A',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )
    ]);
  }
}
