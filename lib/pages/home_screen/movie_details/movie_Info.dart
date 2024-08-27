import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/pages/home_screen/api/api_constant.dart';
import 'package:movie/pages/home_screen/model/movieDetails.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/home_screen/widgets/category_view_widget.dart';
import 'package:movie/pages/watch_list/cubit/movies_state.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_navigetor.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_view_model.dart';
import 'package:movie/pages/watch_list/widgets/book_mark_widget.dart';

import '../../../app_colors.dart';

class MovieInfo extends StatefulWidget {
 MovieDetails movie;

  MovieInfo({
    required this.movie
  });

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> implements WatchListNagvigetor{
  WatchListViewModel viewModel =WatchListViewModel();
  bool isExpanded=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.nagvigetor=this;
    viewModel.getAllMoviesFromFireStore();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.movie.title!,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Release Date: ${widget.movie.releaseDate}',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.lightGrayColor,
            ),
          ),
        ),
        SizedBox(height: 16),
        BlocBuilder<WatchListViewModel,MoviesState>(
          bloc: viewModel,
          builder: (context,state){
            if(state is SuccessState) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(ApiConstant.baseImageUrl +
                                widget.movie.posterPath!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                          top: -6,
                          left: -7,
                          child: BookMarkWidget(
                              viewModel: viewModel, movie: Movie.fromJson(widget
                              .movie.toJson()),isBooked:state.movieList.any((movieSaved){
                            return movieSaved.id==widget.movie.id;
                          })))
                    ],
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Wrap(children: widget.movie.genres!.map((category){
                         return CategoryViewWidget(categoryName: category.name??"");
                       }).toList(),),
                        SizedBox(height: 15),
                        AnimatedCrossFade(
                          firstChild: Text(
                            widget.movie.overview??'',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.lightGrayColor,

                            ),

                          ),
                          secondChild: Text(widget.movie.overview??'',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.lightGrayColor,

                            ),),
                          crossFadeState: isExpanded
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: Duration(milliseconds: 200),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: Text(isExpanded ? 'Read less' : 'Read more',style: TextStyle(color: AppColors.yellowColor,fontSize: 18),),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 24.0,
                            ),
                            SizedBox(width: 5),
                            Text(
                              widget.movie.voteAverage?.toString() ?? 'N/A',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.lightGrayColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }else if (state is ErrorState){
              return Text('Something Went Wrong');
            }
            else if(state is LoadingState){
              return Center(child:Padding(
                padding: const EdgeInsets.all(10.0),
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.whiteColor,
                  size: 50,
                ),
              ));
            }
            return Container();
          },
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String info1, String info2) {
    return Row(
      children: [
        _buildInfoContainer(context, info1),
        SizedBox(width: 10),
        _buildInfoContainer(context, info2),
      ],
    );
  }

  Widget _buildInfoContainer(BuildContext context, String info) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkGrayColor, width: 2),
      ),
      child: Center(
        child: Text(
          info,
          style: TextStyle(color: AppColors.whiteColor),
          textAlign: TextAlign.center,
        ),
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
