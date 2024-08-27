import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/pages/browse/Models/MovieResponse.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    final String baseUrl = "https://image.tmdb.org/t/p/w500/";

    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF514F4F), // Set the background color to black
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded( // Ensures the image takes up the available space
              child: Center(
                child: CachedNetworkImage(
width: double.infinity,

                  imageUrl: "$baseUrl${movie.posterPath}",
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.fill,
                // Ensures the image covers the entire container
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(

                children: [
                  Text(
                    movie.title!,
                    style: TextStyle(color: Colors.white, fontSize: 22), // Set text color to white
                    overflow: TextOverflow.ellipsis, // Ellipsize the text if it overflows
                    maxLines: 7, // Limit to one line
                  ),
                  SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star,color: Colors.yellow,),
                      SizedBox(width: 5),
                      Center(
                        child: Text(
                          movie.voteAverage.toString(), // Convert int to String
                          style: TextStyle(color: Colors.white), // Set text color to white for visibility
                        ),
                      ),
                      
                    ],
                  ),
                  Text(movie.releaseDate??"",style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
