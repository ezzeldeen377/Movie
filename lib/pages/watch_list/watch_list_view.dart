import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/watch_list/cubit/movies_state.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_view_model.dart';
import 'package:movie/pages/watch_list/widgets/watch_item.dart';

class WatchList extends StatefulWidget {
  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList>  {
  WatchListViewModel viewModel = WatchListViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getAllMoviesFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      color:AppColors.blackColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'WatchList',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ElevatedButton.icon(
                  label: Text('Delete All'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yellowColor,
                    foregroundColor: AppColors.backgroundColor,
                  ),

                    onPressed: (){},
                    icon: Icon(Icons.delete),
                )
              ],
            ),
            BlocConsumer<WatchListViewModel,MoviesState>(
              listener: (context,state){
                      if(state is FinishState){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.finishMessage))
                        );
                      }
              },
              bloc:viewModel ,

              builder: (context,state){
                if(state is LoadingState){
                  return LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.whiteColor,
                    size: 50,
                  );
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
      ),
    );
  }

}