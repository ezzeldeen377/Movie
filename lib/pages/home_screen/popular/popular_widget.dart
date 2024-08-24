import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie/app_colors.dart';

import '../api/api_constant.dart';
import '../model/popular_response.dart';

class PopularWidget extends StatelessWidget {
  final List<Popular> popularList;

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

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display video or placeholder for the video
                      Container(
                        width: double.infinity,
                        height: screenHeight * 0.22,
                        color: Colors.grey[300], // Placeholder color
                        child: Stack(
                          alignment: Alignment.center, // Center the play icon
                          children: [
                            Image.network(
                              fullImageUrl,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            Icon(
                              Icons.play_circle_filled, // Play icon
                              color: AppColors.whiteColor,
                              size: screenWidth * 0.17, // Adjust size
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        movie.title ?? 'No title',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05, // Adjust font size
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Release Date: ${movie.releaseDate ?? 'No date'}',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04, // Adjust font size
                          color: Colors.grey[600],
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
