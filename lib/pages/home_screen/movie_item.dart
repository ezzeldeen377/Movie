import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../app_colors.dart';
import 'api/api_constant.dart';
import 'model/movie_response.dart';
import 'movie_details/movie_details_logic.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    final posterPath = movie.posterPath?.startsWith('/') ?? false
        ? movie.posterPath!.substring(1)
        : movie.posterPath ?? "";
    final fullImageUrl = ApiConstant.imageUrl + posterPath;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsLogic(
              movieId: movie.id.toString(),
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        margin: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.darkGrayColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: fullImageUrl,
                width: double.infinity,
                height: MediaQuery.of(context).size.width * 0.45,
                fit: BoxFit.fill,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: Colors.cyan,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                movie.title ?? "",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                movie.releaseDate ?? "",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: AppColors.whiteColor,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20.0,
                  ),
                  SizedBox(width: 3),
                  Text(
                    movie.voteAverage?.toString() ?? 'N/A',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.lightGrayColor,
                    ),
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
