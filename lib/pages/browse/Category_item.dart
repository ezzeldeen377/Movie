import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/pages/browse/Models/CategoryResponse.dart';

class CategoryItem extends StatelessWidget {
  final Category categoryItem;

  CategoryItem({required this.categoryItem});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: "https://image.tmdb.org/t/p/w500/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg",
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.fill, // Ensures the image covers the entire container
          width: double.infinity, // Makes the image fill the width of its container
          height: double.infinity, // Makes the image fill the height of its container
        ),
        Text(
          categoryItem.name ?? "",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ],
    );
  }
}
