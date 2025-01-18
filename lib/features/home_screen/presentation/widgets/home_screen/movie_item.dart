import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/core/api/api_constants.dart';
import 'package:movie/core/theme/app_colors.dart';
import 'package:movie/features/watch_list/presentation/widgets/book_mark_widget.dart';

import '../../../data/models/movie_response.dart';
import '../../pages/movie_details_view.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final posterPath = movie.posterPath?.startsWith('/') ?? false
        ? movie.posterPath!.substring(1)
        : movie.posterPath ?? "";
    final fullImageUrl = ApiConstants.imageUrl + posterPath;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsView(
              movieId: movie.id.toString(),
              movieName: movie.title ?? "",
            ),
          ),
        );
      },
      child: Container(
        width: 130.w,
        margin:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
        decoration: BoxDecoration(
          color: AppColors.forGroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
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
                    height: 170.h,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: AppColors.whiteColor,
                        size: 50.h,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  top: -6,
                  left: -7,
                  child: BookMarkWidget(
                    movie: movie,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 15.h, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    movie.releaseDate ?? "",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 13.h, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      ImageIcon(
                        const AssetImage('assets/icons/star_icon.png'),
                        color: AppColors.yellowColor,
                      ),
                      const SizedBox(width: 7),
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
        ),
      ),
    );
  }
}
