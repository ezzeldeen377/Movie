import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/home_screen/api/api_constant.dart';
import 'package:movie/pages/home_screen/model/movieDetails.dart';
import 'package:movie/pages/home_screen/movie_details/movie_details_view.dart';
import 'package:movie/pages/watch_list/cubit/movies_state.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_navigetor.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_view_model.dart';
import 'package:movie/pages/watch_list/widgets/book_mark_widget.dart';

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
              extentRatio: .20,
                motion: DrawerMotion(),
                children: [
                  SlidableAction(
                    borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10)
          ),
                    onPressed: (context){
                      viewModel.removeMovieFromFireStore(widget.movie);
                    },
                    backgroundColor:AppColors.yellowColor,
                    foregroundColor: AppColors.blackColor,
                    icon: Icons.delete,
                    label: 'Delete',
                    padding: EdgeInsets.all(10),
                  )
          ]),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=>MovieDetailsView(movieId: widget.movie.id.toString())));
              },
              child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // Base image
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          topRight: Radius.circular(15)
                        ),
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
                     Positioned(
                         top: -6,
                         left: -7,
                         child: BookMarkWidget(viewModel: viewModel, movie: widget.movie,isBooked: true,))
                    ],
                  ),
                  SizedBox(width: 15,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(widget.movie.title??'',style: TextStyle(color: AppColors.whiteColor),), // movie name
                      Text(widget.movie.releaseDate??"",style: TextStyle(color: AppColors.whiteColor)),    //relasse data
                      Row(
                        children: [
                          Icon(Icons.star,size: 25,color: AppColors.yellowColor,),
                          Text(widget.movie.voteAverage!.toStringAsFixed(1),style: TextStyle(color: AppColors.whiteColor)),                      ],
                      )//actors names

                    ],
                  )
                ],
              ),
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
