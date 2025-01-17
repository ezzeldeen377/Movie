import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/features/home_screen/data/models/movie_response.dart';
import 'package:movie/features/watch_list/presentation/bloc/movies_state.dart';
import 'package:movie/features/watch_list/presentation/bloc/watch_list_view_model.dart';

class BookMarkWidget extends StatelessWidget {
  final Movie movie;
  const BookMarkWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<WatchListViewModel>();
    return BlocBuilder<WatchListViewModel, WatchListState>(
        builder: (context, state) {
          final movies = state.movies??[];

  bool isBooked = movies.any((watchListMovie) {
    return watchListMovie.id == movie.id;
  });
  return InkWell(
    onTap: () {
      if (!isBooked) {
        viewModel.addMovieToFireStore(movie);
      } else {
        viewModel.removeMovieFromFireStore(movie);
      }
    },
    child: Stack(alignment: Alignment.center, children: [
      ImageIcon(
        const AssetImage('assets/icons/label_icon.png'),
        size: 40, // Adjust size as needed
        color: isBooked
            ? AppColors.yellowColor
            : AppColors.darkGrayColor, // Adjust color as needed
      ),
      ImageIcon(
        isBooked
            ? const AssetImage('assets/icons/check_icon.png')
            : const AssetImage('assets/icons/add_icon.png'),
        size: 20, // Adjust size as needed
        color: Colors.white, // Adjust color as needed
      )
    ]),
  );

    });
    
  }
}
