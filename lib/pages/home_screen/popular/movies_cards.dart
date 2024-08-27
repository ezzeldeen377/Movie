import 'package:flutter/material.dart';
import 'package:movie/app_colors.dart';

import '../api/api_constant.dart';
import '../model/movie_response.dart';
import '../movie_details/movie_details_view.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final double screenWidth;
  final double screenHeight;

  MovieCard({
    required this.movie,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    // Create the full image URL based on the current movie
    final posterPath = movie.posterPath?.startsWith('/') ?? false
        ? movie.posterPath!.substring(1)
        : movie.posterPath ?? "";
    final fullImageUrl = ApiConstant.imageUrl + posterPath;

    final posterBackDropPath = movie.backdropPath ?? "";
    final fullImageUrl2 = ApiConstant.imageUrl + posterBackDropPath;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsView(
              movieId: movie.id.toString(),
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
            height: screenHeight * 0.30,
            fit: BoxFit.fill,
          ),
          Icon(
            Icons.play_circle_filled,
            color: AppColors.whiteColor,
            size: screenWidth * 0.17, // Adjust size
          ),
        ]),
        // Play icon positioned at the center of the large image

        // Overlay image positioned at the bottom
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                fullImageUrl, // Use different image URL if needed
                fit: BoxFit.fill,
                width: screenWidth * 0.35,
                height: screenHeight * 0.25,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: screenWidth * .6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        movie.title ?? 'No title',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05, // Adjust font size
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                        ),
                        softWrap: true,
                        textAlign: TextAlign.start,
                        maxLines: 2, // Limits the title to 2 lines
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Release Date: ${movie.releaseDate ?? 'No date'}',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04, // Adjust font size
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
  }
}
