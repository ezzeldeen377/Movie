import 'package:flutter/material.dart';
import 'package:movie/pages/home_screen/widgets/cast_widget.dart';

class MovieCast extends StatelessWidget {
  final dynamic credits;

  MovieCast({required this.credits});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: CastWidget(credits: credits),
    );
  }
}
