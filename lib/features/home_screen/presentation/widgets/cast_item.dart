import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/core/api/api_constants.dart';

import 'package:movie/features/home_screen/data/models/movieDetails.dart';


class CastItem extends StatelessWidget {
  final Cast cast;
  const CastItem({super.key, required this.cast});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SizedBox(
            width:80,
            height: 80,
            child: ClipOval(

                child: CachedNetworkImage(
                  imageUrl:  ApiConstants.baseImageUrl+(cast.profilePath??''),
              placeholder: (context, url) => Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.whiteColor,
                  size: 50,
                ),
              ),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, color: AppColors.whiteColor,),
                  fit: BoxFit.cover,
                )
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cast.originalName ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  cast.character ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 10,
                      ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
