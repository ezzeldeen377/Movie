import 'package:flutter/material.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/features/browse/presentation/widgets/CategoryPhoto.dart';

class CategoryItem extends StatelessWidget {
  final Category categoryItem;
  final int index;

  const CategoryItem({super.key, required this.categoryItem,required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
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
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                categoryItem.name!,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 20,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
