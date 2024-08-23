import 'package:flutter/material.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/browse/browse.dart';
import 'package:movie/pages/home_screen/home_screen.dart';
import 'package:movie/pages/search/search.dart';
import 'package:movie/pages/watch_list/watch_list_view.dart';

class InitRoute extends StatefulWidget {
  static const String routeName='initRoute';

  @override
  State<InitRoute> createState() => _InitRouteState();
}

class _InitRouteState extends State<InitRoute> {
  int selectedIndex=0;
  List<Widget>pagesList=[HomeScreen(),Search(),Browse(),WatchList()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pagesList[selectedIndex],
      bottomNavigationBar:Theme(
          data: Theme.of(context).copyWith(
            canvasColor: AppColors.primaryColor
          ),
          child:BottomNavigationBar(
            currentIndex: selectedIndex,

          onTap: (index){
            selectedIndex=index;
            setState(() {

            });
          },
        items: [
          BottomNavigationBarItem(

            icon: ImageIcon(AssetImage('assets/icons/home_icon.png')),
            label: 'HOME'
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/search_icon.png')),
            label: 'SEARCH'
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/browse_icon.png')),
            label: 'BROWSE'
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/watchlist_icon.png')),
            label: 'WATCHLIST'
          ),
        ],
      )

      )
    );
  }
}
