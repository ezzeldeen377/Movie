import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../widgets/Movie_list_widget.dart';
import '../model/movie_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MoreLikeUi extends StatelessWidget {
  final List<Movie> moreLike;

  MoreLikeUi({required this.moreLike});

  @override
  Widget build(BuildContext context) {
    return MovieListWidget(
      title: AppLocalizations.of(context)!.more,
      movies: moreLike,
      backgroundColor: AppColors.primaryColor,
    );
  }
}
