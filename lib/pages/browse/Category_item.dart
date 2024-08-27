import 'package:flutter/material.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/browse/CategoryPhoto.dart';
import 'package:movie/pages/browse/Models/CategoryResponse.dart';

class CategoryItem extends StatelessWidget {
  final Category categoryItem;

  CategoryItem({required this.categoryItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkGrayColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            categoryItem.imagePath,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.14,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 10),
          Flexible(
            child: Container(
              child: Text(
                categoryItem.name!,
                style: TextStyle(color: Colors.white, fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
