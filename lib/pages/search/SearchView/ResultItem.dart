import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/home_screen/model/movieDetails.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/home_screen/movie_details/Movie_details_widget.dart';
import 'package:movie/pages/home_screen/movie_details/movie_details_view.dart';


class ResultItem extends StatelessWidget {

   Movie movie;

  ResultItem({
    required this.movie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsView(movieId:movie.id.toString(),
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5),
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: CachedNetworkImage(
                height: 150,
                width: 100,
                fit: BoxFit.fill,
                imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                placeholder: (context, url) => Center(child: CircularProgressIndicator(color: AppColors.yellowColor,)),
                errorWidget: (context, url, error) => Icon(Icons.error,color: AppColors.whiteColor,),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title ?? 'No Title',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      movie.overview ?? 'No Overview',
                      style: TextStyle(color: AppColors.whiteColor,fontSize: 12),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20,
                        ),
                        SizedBox(
                            width: 5),
                        Text(
                          movie.voteAverage?.toStringAsFixed(1)??'',
                          style: TextStyle(
                              color: AppColors.whiteColor,fontSize: 12),
                        ),
                        SizedBox(
                            width: 5),
                        Icon(
                          Icons.calendar_today,
                          color: AppColors.whiteColor,
                          size: 12,
                        ),
                        SizedBox(
                            width: 5),
                        Text(
                          movie.releaseDate??'',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 12),
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
