import 'package:flutter/material.dart';

import '../../../app_colors.dart';

class MovieInfo extends StatelessWidget {
  final String title;
  final String? releaseDate;
  final String overview;
  final String posterUrl;
  final String popularity;
  final String language;
  final String runtime;
  final String revenue;
  final double? voteAverage;

  MovieInfo({
    required this.title,
    this.releaseDate,
    required this.overview,
    required this.posterUrl,
    required this.popularity,
    required this.language,
    required this.runtime,
    required this.revenue,
    this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
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
            'Release Date: $releaseDate',
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
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(posterUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(context, popularity, language),
                  SizedBox(height: 10),
                  _buildInfoRow(context, runtime, revenue),
                  SizedBox(height: 15),
                  Text(
                    overview,
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
                        voteAverage?.toString() ?? 'N/A',
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
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String info1, String info2) {
    return Row(
      children: [
        _buildInfoContainer(context, info1),
        SizedBox(width: 10),
        _buildInfoContainer(context, info2),
      ],
    );
  }

  Widget _buildInfoContainer(BuildContext context, String info) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkGrayColor, width: 2),
      ),
      child: Center(
        child: Text(
          info,
          style: TextStyle(color: AppColors.whiteColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
