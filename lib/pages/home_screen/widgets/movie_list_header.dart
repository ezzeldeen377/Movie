import 'package:flutter/material.dart';

import '../../../../app_colors.dart';

class MovieListHeader extends StatelessWidget {
  final String title;

  MovieListHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 17),
      ),
    );
  }
}
