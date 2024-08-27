import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/search/Cubit/search_View_Model.dart';

class SearchStateDisplay extends StatelessWidget {
  final SearchState state;
  final TextEditingController searchController;
  final Function() onRetry;

  const SearchStateDisplay({
    required this.state,
    required this.searchController,
    required this.onRetry,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.size.height * 0.02;
    final iconSize = mediaQuery.size.height * 0.08;

    if (state.isLoading) {
      return Center(child: CircularProgressIndicator(color: AppColors.yellowColor));
    }
    if (state.hasError) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'An error occurred, please try again',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: mediaQuery.size.height * 0.025,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: padding),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellowColor,
                  padding: EdgeInsets.symmetric(horizontal: padding * 2, vertical: padding),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: onRetry,
                child: Text(
                  'Try Again',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: mediaQuery.size.height * 0.022,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (state.results.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageIcon(
                AssetImage('assets/icons/icon_background.png'),
                color: AppColors.whiteColor,
                size: iconSize,
              ),
              SizedBox(height: padding),
              Text(
                'No results found',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox.shrink(); // Empty widget as a placeholder for the movie list
  }
}
