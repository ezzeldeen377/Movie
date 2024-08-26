import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/pages/home_screen/api/api_constant.dart';
import 'package:movie/pages/home_screen/api/api_manager.dart';
import 'package:movie/pages/home_screen/model/movieDetails.dart';
import 'package:movie/pages/home_screen/widgets/cast_item.dart';


class CastWidget extends StatelessWidget {
  Credits credits;
  CastWidget({required this.credits});
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
