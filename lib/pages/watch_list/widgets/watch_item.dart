

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/home_screen/api/api_constant.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/home_screen/movie_details/movie_details_view.dart';
import 'package:movie/pages/watch_list/cubit/movies_state.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_view_model.dart';
import 'package:movie/pages/watch_list/widgets/book_mark_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class WatchItem extends StatefulWidget {
  Movie movie;
  WatchItem({required this.movie});
  @override
  State<WatchItem> createState() => _WatchItemState();
}

class _WatchItemState extends State<WatchItem> {
  WatchListViewModel viewModel = WatchListViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WatchListViewModel,MoviesState>(
      listener: (context,state){
        if(state is FinishState){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.finishMessage))
          );
        }
      },
      bloc: viewModel,
      builder: (context,state){
        return Container(
          height:120,

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
                    label:AppLocalizations.of(context)!.delete,
                    padding: EdgeInsets.all(10),
                  )
          ]),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=>MovieDetailsView(movieId: widget.movie.id.toString())));
              },
              child: Container(decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blackColor.withOpacity(.8),
                    blurRadius: 10,
                    spreadRadius: 6
                  )
                ]
              ),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Stack(
                        children: [
                          // Base image
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15)
                            ),
                            child: CachedNetworkImage(
                              imageUrl:  ApiConstant.baseImageUrl+widget.movie.posterPath!,
                                  placeholder: (context, url) => Center(
                                    child:
                                        LoadingAnimationWidget.staggeredDotsWave(
                                      color: AppColors.whiteColor,
                                      size: 50,
                                    ),
                                  ),
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
                             child: BookMarkWidget( movie: widget.movie,)
                         )
                        ],
                      ),
                    ),
                    SizedBox(width: 15,),
                    Container(
                      width: 200,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(widget.movie.title??'',style: TextStyle(color: AppColors.whiteColor),maxLines: 3,softWrap: true,),
                          Text(
                            widget.movie.overview ?? 'No Title',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 10),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),// movie name
                          Row(
                            children: [
                              Icon(Icons.star,size: 20,color: AppColors.yellowColor,),
                              SizedBox(width: 5,),
                              Text(widget.movie.voteAverage!.toStringAsFixed(1),
                                  style: TextStyle(color: AppColors.whiteColor,fontSize: 12)),
                              SizedBox(width: 5,),
                              Icon(Icons.date_range,size: 17,color: AppColors.yellowColor,),
                              SizedBox(width: 5,),
                              Text(widget.movie.releaseDate??"",
                                  style: TextStyle(color: AppColors.whiteColor,fontSize: 12)),    //relasse data

                            ],

                          )//actors names

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }


}
