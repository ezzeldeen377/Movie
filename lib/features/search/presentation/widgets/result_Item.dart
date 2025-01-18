import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/theme/app_colors.dart';
import 'package:movie/features/home_screen/data/models/movie_response.dart';
import 'package:movie/features/home_screen/presentation/pages/movie_details_view.dart';

class ResultItem extends StatelessWidget {
  final Movie movie;

  const ResultItem({
    required this.movie,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsView(
              movieId: movie.id.toString(),
              movieName: movie.title ?? '',
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: CachedNetworkImage(
                height: 150.h,
                width: 100.w,
                fit: BoxFit.fill,
                imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                  color: AppColors.yellowColor,
                )),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      movie.title ?? 'No Title',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 16.h),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      movie.overview ?? 'No Overview',
                      style: TextStyle(
                          color: AppColors.whiteColor, fontSize: 12.h),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.h,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          movie.voteAverage?.toStringAsFixed(1) ?? '',
                          style: TextStyle(
                              color: AppColors.whiteColor, fontSize: 12.h),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.calendar_today,
                          color: AppColors.whiteColor,
                          size: 12.h,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          movie.releaseDate ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 12.h),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
