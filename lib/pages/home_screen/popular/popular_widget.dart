import 'package:flutter/material.dart';

import '../model/movie_response.dart';
import 'movie_carousel.dart';

class PopularWidget extends StatelessWidget {
  final List<Movie> popularList;

  PopularWidget({required this.popularList});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.05), // Adjust top padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: MovieCarousel(
              popularList: popularList,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
          ),
        ],
      ),
    );
  }
}
