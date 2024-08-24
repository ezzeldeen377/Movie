import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/watch_list/cubit/movies_state.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_navigetor.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_view_model.dart';
import 'package:movie/pages/watch_list/model/MovieResponse.dart';
import 'package:movie/pages/watch_list/widgets/watch_item.dart';

class WatchList extends StatefulWidget {
  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> implements WatchListNagvigetor {
  WatchListViewModel viewModel = WatchListViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getAllMoviesFromFireStore();
    viewModel.nagvigetor=this;
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      color:AppColors.blackColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(onPressed: (){
            viewModel.addMovieToFireStore(Movie(id: 3,title: 'spider man ',posterPath: 'assets/images/app_icon.png'));
      }, child: Text('add')),

          Text('WatchList',style: TextStyle(color: AppColors.whiteColor,fontSize: 25),),
          BlocConsumer<WatchListViewModel,MoviesState>(
            listener: (context,state){
                    if(state is FinishState){
                      viewModel.showSnakeBar(state.finishMessage);
                    }
            },
            bloc:viewModel ,

            builder: (context,state){
              if(state is LoadingState){
                return CircularProgressIndicator(color:  AppColors.whiteColor,);
              }else if(state is ErrorState){
                return Expanded(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ImageIcon(AssetImage('assets/icons/no_data_icon.png'),size: 100,color: AppColors.whiteColor,),
                      SizedBox(height: 10,),
                      Text(state.errorMessage,style: TextStyle(color: AppColors.whiteColor),textAlign: TextAlign.center,),
                    ],
                  ),
                );
              }else if(state is SuccessState){
                return Expanded(
                  child: ListView.separated(
                    separatorBuilder:(context,index)=> Divider(
                      thickness: 3,color: AppColors.darkGrayColor,
                    endIndent: MediaQuery.of(context).size.width*0.1,
                    indent: MediaQuery.of(context).size.width*0.1,
                    ),
                      itemBuilder: (context,index)=>Padding(
                        padding: const EdgeInsets.all(15),
                        child: WatchItem(movie: state.movieList[index],),
                      ),
                  itemCount: state.movieList.length,
                  ),
                );
              }
              return Container();
          },

          ),
        ],
      ),
    );
  }

  void showSnakeBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
    viewModel.getAllMoviesFromFireStore();
  }
}