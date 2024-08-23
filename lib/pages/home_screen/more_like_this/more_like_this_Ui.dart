import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/pages/home_screen/model/NewsReleases.dart';
import '../../../app_colors.dart';
import '../api/api_constant.dart';
import '../movie_details/movie_details_logic.dart';

class MoreLikeUi extends StatelessWidget {
  final List<Releases> moreLike;

  MoreLikeUi({required this.moreLike});

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
              'More like this',
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
              itemCount: moreLike.length,
              itemBuilder: (context, index) {
                final moreLike1 = moreLike[index];
                final posterPath =
                moreLike1.posterPath?.startsWith('/') ?? false
                    ? moreLike1.posterPath!.substring(1)
                    : moreLike1.posterPath ?? "";
                final fullImageUrl = ApiConstant.imageUrl + posterPath;

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailsLogic(
                                movieId: moreLike1.id.toString() ?? ""),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.35,
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
                            height: MediaQuery
                                .of(context)
                                .size
                                .width * 0.45,
                            // Adjust height as needed
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                Center(
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
                            moreLike1.title ?? "",
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
                            moreLike1.releaseDate ?? "",
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
                                moreLike1.voteAverage?.toString() ?? 'N/A',
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
