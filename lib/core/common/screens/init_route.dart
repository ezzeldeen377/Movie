import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/common/app_provider/app_cubit.dart';
import 'package:movie/core/di/di.dart';
import 'package:movie/core/theme/app_colors.dart';
import 'package:movie/features/browse/presentation/bloc/browse_view_model.dart';
import 'package:movie/features/browse/presentation/pages/browse.dart';
import 'package:movie/features/home_screen/presentation/bloc/home_screen/home_screen_view_model.dart';
import 'package:movie/features/search/presentation/pages/search.dart';
import 'package:movie/features/home_screen/presentation/pages/home_screen.dart';
import 'package:movie/features/watch_list/presentation/pages/watch_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InitRoute extends StatefulWidget {
  static const String routeName = 'initRoute';

  const InitRoute({super.key});

  @override
  State<InitRoute> createState() => _InitRouteState();
}

class _InitRouteState extends State<InitRoute> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  // List of pages with BlocProvider
  final List<Widget> _pages = [
    BlocProvider(
      create: (context) => getIt<HomeScreenViewModel>()
        ..getPopular(context.read<AppCubit>().state)
        ..getNewReleases( context.read<AppCubit>().state,
            fromPagination: false)
        ..getRecommended( context.read<AppCubit>().state,fromPagination: false),
      child: const HomeScreen(),
    ),
    Search(),
    BlocProvider(
      create: (context) => getIt<BrowseViewModel>()
        ..getCategory(context.read<AppCubit>().state),
      child: const Browse(),
    ),
    const WatchList(),
  ];

  @override
  void dispose() {
    _pageController.dispose(); // Dispose the PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index; // Update selected index on page change
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: AppColors.primaryColor),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _pageController
                  .jumpToPage(index); // Navigate to the selected page
            });
          },
          items: [
            BottomNavigationBarItem(
              icon:  ImageIcon(const AssetImage('assets/icons/home_icon.png'),size: 20.h,),
              label: AppLocalizations.of(context)!.home,
            ),
            BottomNavigationBarItem(
              icon:  ImageIcon(const AssetImage('assets/icons/search_icon.png'),size: 20.h),
              label: AppLocalizations.of(context)!.search,
            ),
            BottomNavigationBarItem(
              icon:  ImageIcon(const AssetImage('assets/icons/browse_icon.png'),size: 20.h),
              label: AppLocalizations.of(context)!.browse,
            ),
            BottomNavigationBarItem(
              icon:  ImageIcon(
                  const AssetImage('assets/icons/watchlist_icon.png'),size: 20.h),
              label: AppLocalizations.of(context)!.watch_list,
            ),
          ],
        ),
      ),
    );
  }
}
