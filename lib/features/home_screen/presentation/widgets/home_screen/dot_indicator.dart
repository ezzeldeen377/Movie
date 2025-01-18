import 'package:flutter/material.dart';
import 'package:movie/core/theme/app_colors.dart';

class DotIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const DotIndicator({super.key, 
    required this.currentIndex,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? AppColors.yellowColor : Colors.grey,
          ),
        );
      }),
    );
  }
}