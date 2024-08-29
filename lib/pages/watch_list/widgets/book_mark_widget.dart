import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/watch_list/cubit/movies_state.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_view_model.dart';

class BookMarkWidget extends StatefulWidget {

  Movie movie;
  BookMarkWidget({required this.movie});

  @override
  State<BookMarkWidget> createState() => _BookMarkWidgetState();
}

class _BookMarkWidgetState extends State<BookMarkWidget> {
  WatchListViewModel viewModel = WatchListViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getAllMoviesFromFireStore();

  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WatchListViewModel,MoviesState>(
      bloc: viewModel,
      builder:(context, state) {
        if(state is SuccessState){
          bool isBooked=state.movieList.any((watchListMovie){
            return watchListMovie.id==widget.movie.id;
          });
          return  InkWell(
            onTap: (){
              if(!isBooked) {
                viewModel.addMovieToFireStore(widget.movie);
              }else{
                viewModel.removeMovieFromFireStore(widget.movie);
              }
            },
            child: Stack(alignment: Alignment.center,
                children:[
                  ImageIcon(
                    AssetImage('assets/icons/label_icon.png'),
                    size: 40, // Adjust size as needed
                    color:isBooked? AppColors.yellowColor:AppColors.darkGrayColor, // Adjust color as needed
                  ),
                  ImageIcon(isBooked?
                  AssetImage('assets/icons/check_icon.png'):
                  AssetImage('assets/icons/add_icon.png'),
                    size: 20, // Adjust size as needed
                    color: Colors.white, // Adjust color as needed
                  )

                ]
            ),
          );
        }
        return SizedBox.shrink();
      } ,
      listener:(context, state) {
        if (state is FinishState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.finishMessage)));
        }
      } ,

    );
  }

}
