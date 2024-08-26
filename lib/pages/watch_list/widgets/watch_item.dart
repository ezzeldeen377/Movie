import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/home_screen/api/api_constant.dart';
import 'package:movie/pages/watch_list/cubit/movies_state.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_navigetor.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_view_model.dart';

import '../../home_screen/model/movie_response.dart';

class WatchItem extends StatefulWidget {
  Movie movie;
  WatchItem({required this.movie});
  @override
  State<WatchItem> createState() => _WatchItemState();
}

class _WatchItemState extends State<WatchItem> implements WatchListNagvigetor{
  WatchListViewModel viewModel = WatchListViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.nagvigetor=this;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WatchListViewModel,MoviesState>(
      listener: (context,state){
        if(state is FinishState){
          viewModel.showSnakeBar(state.finishMessage);
        }
      },
      bloc: viewModel,
      builder: (context,state){
        return Container(
          height:MediaQuery.of(context).size.height*.18,

          child: Slidable(
            closeOnScroll: true,
            startActionPane: ActionPane(
              extentRatio: .25,
                motion: DrawerMotion(),
                children: [
                  SlidableAction(
                    borderRadius: BorderRadius.circular(15),
                    onPressed: (context){
                      viewModel.removeMovieFromFireStore(widget.movie);
                    },
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,)
          ]),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    // Base image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl:  ApiConstant.baseImageUrl+widget.movie.posterPath!,
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.fill, 
                        width: MediaQuery.of(context).size.width*.3,// Ensures the image covers the entire container// Makes the image fill the height of its container
                        height: MediaQuery.of(context).size.height*.3,// Ensures the image covers the entire container// Makes the image fill the height of its container
                      )

                    ),
                    // Overlay icon
                    Stack(alignment: Alignment.center,
                        children:[
                          ImageIcon(
                            AssetImage('assets/icons/label_icon.png'),
                            size: 40, // Adjust size as needed
                            color: AppColors.yellowColor, // Adjust color as needed
                          ),
                          ImageIcon(
                            AssetImage('assets/icons/check_icon.png'),
                            size: 20, // Adjust size as needed
                            color: Colors.white, // Adjust color as needed
                          ),

                        ]
                    ),
                  ],
                ),
                SizedBox(width: 15,),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.movie.title??'',style: TextStyle(color: AppColors.whiteColor),), // movie name
                    Text('2020',style: TextStyle(color: AppColors.whiteColor)),    //relasse data
                    Text('Tom holand ',style: TextStyle(color: AppColors.whiteColor)),    //actors names

                  ],
                )
              ],
            ),
          ),
        );
      }
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
