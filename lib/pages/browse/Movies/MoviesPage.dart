import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/pages/browse/CategoryPhoto.dart';
import 'package:movie/pages/browse/Movie_item.dart';
import 'package:movie/pages/browse/Movies/Cubit/MovieState.dart';
import 'package:movie/pages/browse/Movies/Cubit/Movie_details_viewModel.dart';

import '../../../app_colors.dart';

class Moviespage extends StatefulWidget {
  static const String routeName = "Moviespage";
  final Category category;
  Moviespage({required this.category});

  @override
  State<Moviespage> createState() => _MoviespageState();
}

class _MoviespageState extends State<Moviespage> {
  MovieDetailsVeiwmodel viewModel = MovieDetailsVeiwmodel();

  @override
  void initState() {
    super.initState();
    viewModel.getMoives(widget.category.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name ?? "",
            style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
      ),
      backgroundColor: Colors.black, // Set the Scaffold background color to black
      body: BlocBuilder<MovieDetailsVeiwmodel, Moviestate>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is LoadingMovieState) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: AppColors.whiteColor,
                size: 50,
              ),
            );
          } else if (state is ErrorMovieState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.errorMessage, style: TextStyle(color: Colors.white)), // Text color should be white for better visibility
                ElevatedButton(
                  onPressed: () {
                    viewModel.getMoives(widget.category.id!);
                  },
                  child: Text("Try Again"),
                ),
              ],
            );
          } else if (state is SuccessMovieState) {
            return Container(
              color: Colors.black,
              // Set the background color of the content to black
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                ),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.4, // Set the fixed height for MovieItem
                    child: MovieItem(movie: state.movieList[index]),
                  );
                },
                itemCount: state.movieList.length,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
