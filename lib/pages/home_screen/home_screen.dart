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
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 350,// النسبة التي يشغلها العنصر الأول
              child: PopularDetails(),
            ),
            Container(color: AppColors.backgroundColor,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'New Releases',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Container(
                    height: 310, // النسبة التي يشغلها العنصر الثاني
                    child: ReleasesDetailsView(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(color: AppColors.backgroundColor,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Recommended',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height: 310, // النسبة التي يشغلها العنصر الثالث
                    child: RecommendeDetails(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
