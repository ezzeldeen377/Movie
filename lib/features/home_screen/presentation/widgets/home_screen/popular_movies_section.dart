import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie/features/home_screen/presentation/widgets/home_screen/dot_indicator.dart';

import '../../../data/models/movie_response.dart';
import 'movies_cards.dart';

class PopularMoviesSection extends StatelessWidget {
  final List<Movie> popularList;

  PopularMoviesSection({
    super.key,
    required this.popularList,
  });

  final ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          // Assign the controller to the CarouselSlider
          itemCount: popularList.length,
          options: CarouselOptions(
            height: 300,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            viewportFraction: 1,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              // Update the index without rebuilding the entire screen
              currentIndexNotifier.value = index;
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return MovieCard(
              movie: popularList[index],
            );
          },
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder<int>(
          valueListenable: currentIndexNotifier,
          builder: (context, currentIndex, child) {
            return DotIndicator(
              currentIndex: currentIndexNotifier.value,
              itemCount: popularList.length,
            );
          },
        )
      ],
    );
  }
}
