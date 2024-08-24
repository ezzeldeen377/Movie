import 'package:flutter/material.dart';
import 'package:movie/pages/home_screen/new_releases/releases_details.dart';
import 'package:movie/pages/home_screen/popular/popular_details.dart';
import 'package:movie/pages/home_screen/recommended/recommended_details.dart';

import '../../app_colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              height: MediaQuery.of(context).size.height *
                  0.4, // النسبة التي يشغلها العنصر الأول
              child: PopularDetails(),
            ),
            Container(
              height: MediaQuery.of(context).size.height *
                  0.3, // النسبة التي يشغلها العنصر الثاني
              child: ReleasesDetails(),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              height: MediaQuery.of(context).size.height *
                  0.4, // النسبة التي يشغلها العنصر الثالث
              child: RecommendeDetails(),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
