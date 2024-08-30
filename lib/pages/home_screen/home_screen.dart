import 'package:flutter/material.dart';
import 'package:movie/pages/home_screen/new_releases/releases_details_view.dart';
import 'package:movie/pages/home_screen/popular/popular_details.dart';
import 'package:movie/pages/home_screen/recommended/recommended_details.dart';
import 'package:movie/pages/settings/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../app_colors.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children:[
        SingleChildScrollView(
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
        Positioned(
          top: 30,
          left: 0 ,
          child: Container(
            width: 55.0, // Set width of the button
            height: 45.0, // Set height of the button
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SettingScreen()));

              },
              foregroundColor: AppColors.blackColor,
              backgroundColor: Color(0xFFFFBB3B), // Background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),  // Border radius for top right
                  bottomRight: Radius.circular(20),  // Border radius for bottom right
                  topLeft: Radius.circular(0),  // No border radius for top left
                  bottomLeft: Radius.circular(0),  // No border radius for bottom left
                ),
              ),
              child: Icon(Icons.settings,size:30), // Settings icon
            ),
          ),
        ),

      ]
    )
    );
  }
}
