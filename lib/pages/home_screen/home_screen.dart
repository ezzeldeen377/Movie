import 'package:flutter/material.dart';
import 'package:movie/pages/home_screen/new_releases/releases_details_view.dart';
import 'package:movie/pages/home_screen/popular/popular_details.dart';
import 'package:movie/pages/home_screen/recommended/recommended_details.dart';

import '../../app_colors.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home_screen';
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
                  0.52, // النسبة التي يشغلها العنصر الأول
              child: PopularDetails(),
            ),
            Container(
              height: MediaQuery.of(context).size.height *
                  0.5, // النسبة التي يشغلها العنصر الثاني
              child: ReleasesDetailsView(),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              height: MediaQuery.of(context).size.height *
                  0.5, // النسبة التي يشغلها العنصر الثالث
              child: RecommendeDetails(),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
