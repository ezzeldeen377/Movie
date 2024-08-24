import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/browse/Category/Cubit/CategoryState.dart';
import 'package:movie/pages/browse/Category/Cubit/Category_details_VeiwModel.dart';
import 'package:movie/pages/browse/Category_item.dart';
import 'package:movie/pages/browse/Movie_item.dart';
import 'package:movie/pages/browse/Movies/MoviesPage.dart';


import '../Api/Api_Manager.dart';

class CategoryDetails extends StatefulWidget {


  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();

}

class _CategoryDetailsState extends State<CategoryDetails> {


  @override
  void initState() {
     super.initState();
    // futureSourceRes = ApiManager.get();
   viewModel.getCategory();
  }
  @override
  CategoryDetailsVeiwmodel viewModel=CategoryDetailsVeiwmodel();
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailsVeiwmodel,Categorystate>(
      bloc: viewModel,
      builder: (context, state) {
      if(state is LoadingCategoryState){
        return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),);
      }
      else if(state is ErrorCategoryState){
        return Column(children: [
          Text(state.ErrorMessage),
          ElevatedButton(onPressed: (){
            ApiManager.getCategory();

          }, child: Text("Try Again"))
        ],);
      }
      else if(state is SuccessCategoryState){
        return Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              return InkWell(onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Moviespage(category: state.categoryList[index],)));
              },child: Container(child: CategoryItem(categoryItem:state.categoryList[index] )));
            },
itemCount:state.categoryList.length ,
          ),

        );
      }
      return Container();
    },);
  }
}
