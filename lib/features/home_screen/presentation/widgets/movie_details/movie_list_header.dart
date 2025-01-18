import 'package:flutter/material.dart';


class MovieListHeader extends StatelessWidget {
  final String title;

  const MovieListHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 17),
      ),
    );
  }
}
