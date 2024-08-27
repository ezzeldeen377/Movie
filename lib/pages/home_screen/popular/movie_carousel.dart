import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../model/movie_response.dart';
import 'movies_cards.dart';

class MovieCarousel extends StatefulWidget {
  final List<Movie> popularList;
  final double screenWidth;
  final double screenHeight;

  MovieCarousel({
    required this.popularList,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  _MovieCarouselState createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.popularList.length,
          options: CarouselOptions(
            height: widget.screenHeight * 0.4,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            viewportFraction: 1,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            var movie = widget.popularList[index];
            return MovieCard(
              movie: movie,
              screenWidth: widget.screenWidth,
              screenHeight: widget.screenHeight,
            );
          },
        ),
        SizedBox(height: 10),
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.popularList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _current = entry.key;
                  });
                },
                child: Container(
                  width: 11.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
