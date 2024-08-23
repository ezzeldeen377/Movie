import 'package:flutter/material.dart';
import '../model/movieDetails.dart';
import '../../../app_colors.dart';
import '../api/api_constant.dart';
import '../more_like_this/more_like_this_logic.dart';

class MovieDetailsUI extends StatelessWidget {
  final MovieDetails movie;

  MovieDetailsUI({required this.movie});

  @override
  Widget build(BuildContext context) {
    final posterPath = movie.posterPath ?? "";
    final fullImageUrl = ApiConstant.imageUrl + posterPath;

    final posterBackDropPath = movie.backdropPath ?? "";
    final fullImage2 = ApiConstant.imageUrl + posterBackDropPath;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          movie.title ?? 'Movie Details',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        iconTheme: IconThemeData(color: AppColors.whiteColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(fullImage2),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Icon(
                  Icons.play_circle_filled,
                  size: 75,
                  color: AppColors.whiteColor,
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.title ?? "Title Not Available",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Release Date: ${movie.releaseDate ??
                    'Release Date Not Available'}',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.lightGrayColor,
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.4,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(fullImageUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0), // Adjust padding as needed
                            decoration: BoxDecoration(
                              color: AppColors.blackColor,
                              // Background color inside the container
                              borderRadius: BorderRadius.circular(12),
                              // Adjust the border radius as needed
                              border: Border.all(
                                color: AppColors.darkGrayColor, // Border color
                                width: 2, // Border width
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Action',
                                style: TextStyle(color: AppColors.whiteColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0), // Adjust padding as needed
                            decoration: BoxDecoration(
                              color: AppColors.blackColor,
                              // Background color inside the container
                              borderRadius: BorderRadius.circular(12),
                              // Adjust the border radius as needed
                              border: Border.all(
                                color: AppColors.darkGrayColor, // Border color
                                width: 2, // Border width
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Action',
                                style: TextStyle(color: AppColors.whiteColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0), // Adjust padding as needed
                            decoration: BoxDecoration(
                              color: AppColors.blackColor,
                              // Background color inside the container
                              borderRadius: BorderRadius.circular(12),
                              // Adjust the border radius as needed
                              border: Border.all(
                                color: AppColors.darkGrayColor, // Border color
                                width: 2, // Border width
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Action',
                                style: TextStyle(color: AppColors.whiteColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0), // Adjust padding as needed
                            decoration: BoxDecoration(
                              color: AppColors.blackColor,
                              // Background color inside the container
                              borderRadius: BorderRadius.circular(12),
                              // Adjust the border radius as needed
                              border: Border.all(
                                color: AppColors.darkGrayColor, // Border color
                                width: 2, // Border width
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Action',
                                style: TextStyle(color: AppColors.whiteColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        movie.overview ?? 'Description not available.',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.lightGrayColor,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 24.0,
                          ),
                          SizedBox(width: 5),
                          Text(
                            movie.voteAverage?.toString() ?? 'N/A',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.lightGrayColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.4,
                child: MoreLikeThisLogic(
                  id: movie.id.toString(),
                )),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
