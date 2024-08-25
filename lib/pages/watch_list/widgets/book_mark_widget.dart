import 'package:flutter/material.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_view_model.dart';

class BookMarkWidget extends StatelessWidget {
  WatchListViewModel viewModel;
  bool isBooked;
  Movie movie;
  BookMarkWidget({this.isBooked=false,required this.viewModel,required this.movie});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(!isBooked) {
          viewModel.addMovieToFireStore(movie);
        }else{
          viewModel.removeMovieFromFireStore(movie);
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
}
