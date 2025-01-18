import 'package:flutter/material.dart';
import 'package:movie/features/home_screen/data/models/movieDetails.dart';
import 'package:movie/features/home_screen/presentation/widgets/movie_details/cast_item.dart';


class CastWidget extends StatelessWidget {
  final Credits credits;
  const CastWidget({super.key, required this.credits});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
        itemBuilder:(context,index){
          return CastItem(cast: credits.cast![index]);

        },
      itemCount:credits.cast?.length,
        );
  }
}
