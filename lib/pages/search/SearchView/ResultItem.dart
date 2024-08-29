import 'package:flutter/material.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/home_screen/model/movieDetails.dart';
import 'package:movie/pages/home_screen/movie_details/Movie_details_widget.dart';


class ResultItem extends StatelessWidget {

  MovieDetails movieDetails;


  ResultItem({
    required this.movieDetails,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.size.height * 0.02;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsWidget(
              movie:movieDetails ,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: padding),
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            movieDetails.posterPath != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${movieDetails.posterPath}',
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
                      movieDetails.title ?? 'No Title',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: mediaQuery.size.height * 0.020),
                    ),
                    SizedBox(height: 4),
                    Text(
                      movieDetails.overview ?? 'No Overview',
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
                        SizedBox(
                            width: mediaQuery.size.width * 0.009),
                        Text(
                          movieDetails.voteAverage!.toStringAsFixed(1),
                          style: TextStyle(
                              color: AppColors.whiteColor),
                        ),
                        SizedBox(
                            width: mediaQuery.size.width * 0.05),
                        Icon(
                          Icons.calendar_today,
                          color: AppColors.whiteColor,
                          size: 12,
                        ),
                        SizedBox(
                            width: mediaQuery.size.width * 0.009),
                        Text(
                          movieDetails.releaseDate??'',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: mediaQuery.size.height * 0.018),
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
  }
}
