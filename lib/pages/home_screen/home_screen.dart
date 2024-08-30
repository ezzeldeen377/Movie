import 'package:flutter/material.dart';
import 'package:movie/pages/home_screen/new_releases/releases_details_view.dart';
import 'package:movie/pages/home_screen/popular/popular_details.dart';
import 'package:movie/pages/home_screen/recommended/recommended_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                      AppLocalizations.of(context)!.new_releases,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Container(
                    height: 320, // النسبة التي يشغلها العنصر الثاني
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
                      AppLocalizations.of(context)!.recommended,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height: 320, // النسبة التي يشغلها العنصر الثالث
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
