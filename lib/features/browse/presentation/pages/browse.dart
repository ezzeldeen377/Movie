import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/features/browse/presentation/bloc/browse_state.dart';
import 'package:movie/features/browse/presentation/bloc/browse_view_model.dart';
import 'package:movie/features/browse/presentation/pages/MoviesPage.dart';
import 'package:movie/features/browse/presentation/widgets/Category_item.dart';
import 'package:provider/provider.dart';
import '../../../../app_provider/app_provider.dart';

class Browse extends StatelessWidget {
  const Browse({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<BrowseViewModel>();
    var pro = Provider.of<AppProvider>(context);
    AppProvider provider = AppProvider(appLanguage: pro.appLanguage);
    return BlocBuilder<BrowseViewModel, BrowseState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state.isLoading) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.whiteColor,
              size: 50.h,
            ),
          );
        } else if (state.isError) {
          return Column(
            children: [
              Text(state.errorMessage!),
              ElevatedButton(
                onPressed: () {
                  viewModel.getCategory(provider.appLanguage);
                },
                child: const Text("Try Again"),
              )
            ],
          );
        } else if (state.isLoaded) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: .8),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10), // إضافة padding حول كل عنصر
                child: InkWell(
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<BrowseViewModel>()
                            ..getMoives(state.categories![index].id,
                                context.watch<AppProvider>().appLanguage),
                          child: Moviespage(
                            category: state.categories![index],
                          ),
                        ),
                      ),
                    );
                  },
                  child: CategoryItem(
                    categoryItem: state.categories![index],
                    index: index,
                  ),
                ),
              );
            },
            itemCount: state.categories?.length,
          );
        }
        return Container();
      },
    );
  }
}
