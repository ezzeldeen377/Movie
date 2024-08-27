import 'package:flutter/material.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_navigetor.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_view_model.dart';

class BookMarkWidget extends StatefulWidget {
  WatchListViewModel viewModel;
  bool isBooked;
  Movie movie;
  BookMarkWidget({this.isBooked=false,required this.viewModel,required this.movie});

  @override
  State<BookMarkWidget> createState() => _BookMarkWidgetState();
}

class _BookMarkWidgetState extends State<BookMarkWidget> implements WatchListNagvigetor{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.viewModel.nagvigetor=this;
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(!widget.isBooked) {
          widget.viewModel.addMovieToFireStore(widget.movie);
        }else{
          widget.viewModel.removeMovieFromFireStore(widget.movie);
        }
      },
      child: Stack(alignment: Alignment.center,
          children:[
            ImageIcon(
              AssetImage('assets/icons/label_icon.png'),
              size: 40, // Adjust size as needed
              color:widget.isBooked? AppColors.yellowColor:AppColors.darkGrayColor, // Adjust color as needed
            ),
            ImageIcon(widget.isBooked?
              AssetImage('assets/icons/check_icon.png'):
            AssetImage('assets/icons/add_icon.png'),
              size: 20, // Adjust size as needed
              color: Colors.white, // Adjust color as needed
            )

          ]
      ),
    );
  }
  @override
  showSnakeBar(String message) {
    // TODO: implement showSnakeBar
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );
  }
}
