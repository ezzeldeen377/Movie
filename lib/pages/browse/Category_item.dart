import 'package:flutter/material.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/browse/CategoryPhoto.dart';
import 'package:movie/pages/browse/Models/CategoryResponse.dart';

class CategoryItem extends StatelessWidget {
  final Category categoryItem;
  int index;

  CategoryItem({required this.categoryItem,required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.white12,
              blurRadius: 10,
              spreadRadius: 5,
          )
        ],
        color: AppColors.darkGrayColor,
        borderRadius:BorderRadius.only(
      topRight: Radius.circular(index%2!=0?10:0),
        bottomLeft: Radius.circular(index%2==0?10:0),
        bottomRight: Radius.circular(index%2!=0?10:0),
        topLeft: Radius.circular(index%2==0?10:0)

    ) ,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius:BorderRadius.only(
                topRight: Radius.circular(index%2!=0?10:0),
                bottomLeft: Radius.circular(index%2==0?10:0),
                bottomRight: Radius.circular(index%2!=0?10:0),
                topLeft: Radius.circular(index%2==0?10:0)

              ) ,
              child: Image.asset(
                categoryItem.imagePath,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                fit: BoxFit.cover,

              ),
            ),
            SizedBox(height: 10),
            Flexible(
              child: Container(
                child: Text(
                  categoryItem.name!,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 20,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
