import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/browse/CategoryPhoto.dart';
import 'package:movie/pages/browse/Models/CategoryResponse.dart';
import 'package:movie/pages/browse/Movie_item.dart';
import 'package:movie/pages/browse/Movies/Cubit/MovieState.dart';
import 'package:movie/pages/browse/Movies/Cubit/Movie_details_viewModel.dart';

import '../../../app_colors.dart';
import '../Api/Api_Manager.dart';
import '../Category/Cubit/CategoryState.dart';
import '../Category/Cubit/Category_details_VeiwModel.dart';
import '../Category_item.dart';

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
        title: Text(widget.category.name ?? "",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF514F4F),
      ),
      backgroundColor: Colors.black, // Set the Scaffold background color to black
      body: BlocBuilder<MovieDetailsVeiwmodel, Moviestate>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is LoadingMovieState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (state is ErrorMovieState) {
            return Column(
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
            return Expanded(
              child: Container(
                color: Colors.black, // Set the background color of the content to black
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Handle tap on movie item
                      },
                      child: MovieItem(movie: state.movieList[index]),
                    );
                  },
                  itemCount: state.movieList.length,
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
