import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/features/home_screen/presentation/bloc/home_screen/home_screen_state.dart';
import 'package:movie/features/home_screen/presentation/bloc/home_screen/home_screen_view_model.dart';
import 'package:movie/features/home_screen/presentation/widgets/home_screen/new_releases_movies_section.dart';
import 'package:movie/features/home_screen/presentation/widgets/home_screen/recommended_movies_section.dart';
import 'package:movie/features/home_screen/presentation/widgets/home_screen/settings_button.dart';
import 'package:movie/features/home_screen/presentation/widgets/home_screen/popular_movies_section.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home_screen';

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      BlocBuilder<HomeScreenViewModel, HomeScreenState>(
        builder: (context, state) {
          if (!state.isAllLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.isError) {
            return Center(
                child: Text(
              state.errorMessage!,
              style: const TextStyle(color: Colors.red),
            ));
          }
          return SingleChildScrollView(
            child: Column(
              spacing: 10.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PopularMoviesSection(popularList: state.popularMovies ?? []),
                NewReleasesMoviesSection(
                  newReleasesMovies: state.newReleasesMovies ?? [],
                ),
                RecommendedMoviesSection(
                    recommendedMovies: state.recommendedMovies ?? []),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
      const SettingsButton()
    ]));
  }
}
