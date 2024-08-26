import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../Movie_list_widget.dart';
import '../model/movie_response.dart';

class MoreLikeUi extends StatelessWidget {
  final List<Movie> moreLike;

  MoreLikeUi({required this.moreLike});

  @override
  Widget build(BuildContext context) {
    return MovieListWidget(
      title: 'More like this',
      movies: moreLike,
      backgroundColor: AppColors.primaryColor,
    );
  }
}
