import 'package:flutter/material.dart';
import 'package:movie/features/home_screen/presentation/widgets/movie_details/cast_widget.dart';

class MovieCast extends StatelessWidget {
  final dynamic credits;

  const MovieCast({super.key, required this.credits});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: CastWidget(credits: credits),
    );
  }
}
