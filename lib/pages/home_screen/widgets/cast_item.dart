import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/home_screen/api/api_constant.dart';
import 'package:movie/pages/home_screen/api/api_manager.dart';
import 'package:movie/pages/home_screen/model/movieDetails.dart';


class CastItem extends StatelessWidget {
  Cast cast;
  CastItem({required this.cast});
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: width*0.57,
      child: Row(
        children: [
          Container(
            width:70,
            height: 70,
            child: ClipOval(

                child: CachedNetworkImage(
                  imageUrl:  ApiConstant.baseImageUrl+(cast.profilePath??''),
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.white,),
                  fit: BoxFit.fill,
                )
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: width*.28,
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(cast.originalName??'',style: TextStyle(color: AppColors.whiteColor,fontSize: 16),),
                Text(cast.character??'',style: TextStyle(color: AppColors.whiteColor,fontSize: 10),)

              ],
            ),
          ),
        ],
      ),
    );
  }
}
