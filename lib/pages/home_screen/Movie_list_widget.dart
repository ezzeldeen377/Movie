import 'package:flutter/material.dart';

import 'model/movie_response.dart';
import 'movie_item.dart';
import 'movie_list_header.dart';

class MovieListWidget extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final Color backgroundColor;

  MovieListWidget({
    required this.title,
    required this.movies,
    this.backgroundColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieListHeader(title: title),
          SizedBox(height: 8),
          Flexible(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieItem(movie: movie);
              },
            ),
          ),
        ],
      ),
    );
  }
}
