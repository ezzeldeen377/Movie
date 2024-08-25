import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../Movie_list_widget.dart';
import '../model/movie_response.dart';

class ReleasesWidget extends StatelessWidget {
  final List<Movie> releasesList;

  ReleasesWidget({required this.releasesList});

  @override
  Widget build(BuildContext context) {
    return MovieListWidget(
      title: 'New Releases',
      movies: releasesList,
      backgroundColor: AppColors.primaryColor,
    );
  }
}
