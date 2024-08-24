import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../app_colors.dart';
import '../api/api_constant.dart';
import '../model/recommended_response.dart';
import '../movie_details/movie_details_logic.dart';

class RecommendedWidget extends StatelessWidget {
  final List<Recommended> recommendedList;

  RecommendedWidget({required this.recommendedList});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      // Set the background color of the ListView area
      padding: EdgeInsets.symmetric(vertical: 8),
      // Add some vertical padding if needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Align children to the start
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            // Add horizontal padding for the title
            child: Text(
              'Recommended',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          SizedBox(height: 8), // Space between title and list
          Flexible(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recommendedList.length,
              itemBuilder: (context, index) {
                final recommended = recommendedList[index];
                final posterPath =
                    recommended.posterPath?.startsWith('/') ?? false
                        ? recommended.posterPath!.substring(1)
                        : recommended.posterPath ?? "";
                final fullImageUrl = ApiConstant.imageUrl + posterPath;

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsLogic(
                            movieId: recommended.id.toString() ?? ""),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    // Adjust width for smaller cards
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    // Adjust margin for more spacing
                    decoration: BoxDecoration(
                      color: AppColors.darkGrayColor,
                      // Background color for the whole container
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10)),
                          // Rounded corners for top of the image
                          child: CachedNetworkImage(
                            imageUrl: fullImageUrl,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.width * 0.45,
                            // Adjust height as needed
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: Colors.cyan,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        SizedBox(height: 3), // Space between image and text
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            recommended.title ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                            ),
                            textAlign: TextAlign.start, // Center-align the text
                            maxLines: 2, // Allow up to 2 lines for the title
                            overflow: TextOverflow
                                .ellipsis, // Show ellipsis if text overflows
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Text(
                            recommended.releaseDate ?? "",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: AppColors.whiteColor,
                            ),
                            textAlign: TextAlign.start, // Center-align the text
                            overflow: TextOverflow.ellipsis, // Handle overflow
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 20.0,
                              ),
                              SizedBox(width: 3),
                              Text(
                                recommended.voteAverage?.toString() ?? 'N/A',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.lightGrayColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
