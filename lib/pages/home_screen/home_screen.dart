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
              margin: EdgeInsets.symmetric(vertical: 8),
              height: MediaQuery.of(context).size.height *
                  0.5, // النسبة التي يشغلها العنصر الأول
              child: PopularDetails(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'New Releases',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height *
                  0.4, // النسبة التي يشغلها العنصر الثاني
              child: ReleasesDetailsView(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Recommended',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
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
