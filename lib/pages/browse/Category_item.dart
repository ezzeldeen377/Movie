import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/pages/browse/CategoryPhoto.dart';
import 'package:movie/pages/browse/Models/CategoryResponse.dart';

class CategoryItem extends StatelessWidget {
  final Category categoryItem;


  CategoryItem({required this.categoryItem,});

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        children: [
      Image.asset(categoryItem.imagePath,width: MediaQuery.of(context).size.width*0.5,
        height:  MediaQuery.of(context).size.height*0.2,fit: BoxFit.fill,),
          Text(categoryItem.name!,style: TextStyle(color: Colors.white,fontSize: 25),)
        ],
      ),
    );
  }
}
