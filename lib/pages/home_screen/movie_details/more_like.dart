import 'package:flutter/material.dart';

import '../more_like_this/more_like_this_details_view.dart';

class MoreLikeThis extends StatelessWidget {
  final String movieId;

  MoreLikeThis({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: MoreLikeThisDetailsView(id: movieId),
    );
  }
}
