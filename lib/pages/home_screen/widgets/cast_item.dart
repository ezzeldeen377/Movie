import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/home_screen/api/api_constant.dart';
import 'package:movie/pages/home_screen/api/api_manager.dart';
import 'package:movie/pages/home_screen/model/movieDetails.dart';


class CastItem extends StatelessWidget {
  Cast cast;
  CastItem({required this.cast});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width:80,
            height: 80,
            child: ClipOval(

                child: CachedNetworkImage(
                  imageUrl:  ApiConstant.baseImageUrl+(cast.profilePath??''),
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
            margin: EdgeInsets.all(10),
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
