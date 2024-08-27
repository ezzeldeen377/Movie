import 'package:flutter/material.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/home_screen/model/movieDetails.dart';
import 'package:movie/pages/home_screen/movie_details/Movie_details_widget.dart';
import 'package:movie/pages/search/model/SourcesMovie.dart';


class MovieList extends StatelessWidget {
  final List<Results> movies;
  final TextEditingController searchController;

  const MovieList({
    required this.movies,
    required this.searchController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.size.height * 0.02;

    return Expanded(
      child: ListView.separated(
        itemCount: movies.length,
        separatorBuilder: (context, index) => Divider(
          color: AppColors.darkGrayColor,
          height: 1,
        ),
        itemBuilder: (context, index) {
          final movie = movies[index];
          final rating = movie.voteAverage ?? 0.0;
          final releaseDate = movie.releaseDate ?? 'No Release Date';

          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsWidget(
                  movie: MovieDetails.fromJson(movie.toJson()),
                ),
              ),
            ),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: padding),
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  movie.posterPath != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      height: mediaQuery.size.height * 0.17,
                      width: mediaQuery.size.width * 0.23,
                      fit: BoxFit.fill,
                    ),
                  )
                      : SizedBox(width: mediaQuery.size.width * 0.05),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title ?? 'No Title',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: mediaQuery.size.height * 0.020,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            movie.overview ?? 'No Overview',
                            style: TextStyle(color: AppColors.whiteColor),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: mediaQuery.size.height * 0.01),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 20,
                              ),
                              SizedBox(width: mediaQuery.size.width * 0.02),
                              Text(
                                rating.toStringAsFixed(1),
                                style: TextStyle(color: AppColors.whiteColor),
                              ),
                              SizedBox(width: mediaQuery.size.width * 0.02),
                              Text(
                                releaseDate,
                                style: TextStyle(color: AppColors.whiteColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
