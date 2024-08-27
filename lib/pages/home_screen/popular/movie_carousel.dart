import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../model/movie_response.dart';
import 'movies_cards.dart';

class MovieCarousel extends StatelessWidget {
  final List<Movie> popularList;
  final double screenWidth;
  final double screenHeight;

  MovieCarousel({
    required this.popularList,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: popularList.length,
      options: CarouselOptions(
        height: screenHeight * 0.4,
        // Adjust height based on screen size
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        viewportFraction: 1,
        enlargeCenterPage: true,
      ),
      itemBuilder: (context, index, realIndex) {
        var movie = popularList[index];
        return MovieCard(
          movie: movie,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        );
      },
    );
  }
}
