import 'package:flutter/material.dart';
import 'package:movie/app_colors.dart';

class CategoryViewWidget extends StatelessWidget {
  String categoryName;
  CategoryViewWidget({required this.categoryName});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.lightGrayColor,
              width: 1
        )
      ),
      child: Text(categoryName,style: TextStyle(color: AppColors.whiteColor),),
    );
  }
}
