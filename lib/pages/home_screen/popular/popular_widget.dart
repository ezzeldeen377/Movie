import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie/app_colors.dart';

import '../api/api_constant.dart';
import '../model/movie_response.dart';

class PopularWidget extends StatelessWidget {
  final List<Movie> popularList;

  PopularWidget({required this.popularList});

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.05), // Adjust top padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            // Use Expanded here to prevent overflow
            child: CarouselSlider.builder(
              itemCount: popularList.length,
              options: CarouselOptions(
                height: screenHeight * 0.4,
                // Adjust height based on screen size
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  // Handle page change if needed
                },
              ),
              itemBuilder: (context, index, realIndex) {
                var movie = popularList[index];

                // Create the full image URL based on the current movie
                final posterPath = movie.posterPath?.startsWith('/') ?? false
                    ? movie.posterPath!.substring(1)
                    : movie.posterPath ?? "";
                final fullImageUrl = ApiConstant.imageUrl + posterPath;

                final posterBackDropPath = movie.backdropPath ?? "";
                final fullImageUrl2 = ApiConstant.imageUrl + posterBackDropPath;

                return Container(
                  child: Stack(
                    children: [
                      // Main image
                      Container(
                        width: double.infinity,
                        height: screenHeight * 0.30,
                        color: Colors.grey[300], // Placeholder color
                        child: Image.network(
                          fullImageUrl2,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),
                      // Overlay image positioned at the bottom
                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: Container(
                          width: screenWidth * 0.3,
                          height: screenHeight * 0.2,
                          color: Colors.grey[200], // Placeholder color
                          child: Image.network(
                            fullImageUrl, // Use different image URL if needed
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      // Play icon positioned at the center of the large image
                      Center(
                        child: Icon(
                          Icons.play_circle_filled,
                          color: AppColors.whiteColor,
                          size: screenWidth * 0.17, // Adjust size
                        ),
                      ),
                      // Add title and release date positioned at the bottom right
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                movie.title ?? 'No title',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  // Adjust font size
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.whiteColor,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Release Date: ${movie.releaseDate ?? 'No date'}',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  // Adjust font size
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
