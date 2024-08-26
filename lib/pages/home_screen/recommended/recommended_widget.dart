import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../widgets/Movie_list_widget.dart';
import '../model/movie_response.dart';

class RecommendedWidget extends StatelessWidget {
  final List<Movie> recommendedList;

  RecommendedWidget({required this.recommendedList});

  @override
  Widget build(BuildContext context) {
    return MovieListWidget(
      title: 'Recommended',
      movies: recommendedList,
      backgroundColor: AppColors.primaryColor,
    );
  }
}
