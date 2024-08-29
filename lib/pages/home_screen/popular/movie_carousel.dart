import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../model/movie_response.dart';
import 'movies_cards.dart';

class MovieCarousel extends StatefulWidget {
  final List<Movie> popularList;


  MovieCarousel({
    required this.popularList,
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
            height:300,
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
            return Container(height: 300,
              child: MovieCard(
                movie: movie,
              ),
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
