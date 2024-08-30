import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/browse/Category/Cubit/CategoryState.dart';
import 'package:movie/pages/browse/Category/Cubit/Category_details_VeiwModel.dart';
import 'package:movie/pages/browse/Category_item.dart';
import 'package:movie/pages/browse/Movies/MoviesPage.dart';
import 'package:movie/pages/browse/Repo/Category/repo/source_repo_impl.dart';
import '../Api/Api_Manager.dart';

class CategoryDetails extends StatefulWidget {
  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
    viewModel.getCategory();
  }

  @override
  CategoryDetailsVeiwmodel viewModel = CategoryDetailsVeiwmodel();

  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailsVeiwmodel, Categorystate>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is LoadingCategoryState) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.whiteColor,
              size: 50,
            ),
          );
        } else if (state is ErrorCategoryState) {
          return Column(
            children: [
              Text(state.ErrorMessage),
              ElevatedButton(
                onPressed: () {
                  viewModel.getCategory();
                },
                child: Text("Try Again"),
              )
            ],
          );
        } else if (state is SuccessCategoryState) {
          return Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: .8
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10), // إضافة padding حول كل عنصر
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Moviespage(
                            category: state.categoryList[index],
                          ),
                        ),
                      );
                    },
                    child: CategoryItem(
                      categoryItem: state.categoryList[index],index:index,
                    ),
                  ),
                );
              },
              itemCount: state.categoryList.length,
            ),
          );
        }
        return Container();
      },
    );
  }
}
