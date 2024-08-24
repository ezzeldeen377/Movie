import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../app_colors.dart';
import '../api/api_constant.dart';
import '../model/NewsReleases.dart';
import '../movie_details/movie_details_logic.dart';

class ReleasesWidget extends StatelessWidget {
  final List<Releases> releasesList;

  ReleasesWidget({required this.releasesList});

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
              'New Releases',
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
              itemCount: releasesList.length,
              itemBuilder: (context, index) {
                final release = releasesList[index];
                final posterPath = release.posterPath?.startsWith('/') ?? false
                    ? release.posterPath!.substring(1)
                    : release.posterPath ?? "";
                final fullImageUrl = ApiConstant.imageUrl + posterPath;

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsLogic(
                            movieId: release.id.toString() ?? ""),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    // Adjust width for smaller cards
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    // Increase margin for more spacing
                    decoration: BoxDecoration(
                      color: AppColors.darkGrayColor,
                      // Background color for the container
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15)),
                          // Rounded corners for the top of the image
                          child: CachedNetworkImage(
                            imageUrl: fullImageUrl,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.width * 0.40,
                            // Make height equal to width for a square
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
                        SizedBox(
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            release.title ?? "",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                            ),
                            textAlign: TextAlign.start, // Center-align the text
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis, // Handle overflow
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
