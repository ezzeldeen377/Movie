import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/pages/home_screen/api/api_constant.dart';
import 'package:movie/pages/home_screen/model/movieDetails.dart';
import 'package:movie/pages/home_screen/model/movie_response.dart';
import 'package:movie/pages/home_screen/widgets/category_view_widget.dart';
import 'package:movie/pages/watch_list/cubit/movies_state.dart';
import 'package:movie/pages/watch_list/cubit/watch_list_view_model.dart';
import 'package:movie/pages/watch_list/widgets/book_mark_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../app_colors.dart';

class MovieInfo extends StatefulWidget {
  MovieDetails movie;

  MovieInfo({required this.movie});

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  WatchListViewModel viewModel = WatchListViewModel();
  bool isExpanded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            AppLocalizations.of(context)!.release_data +(widget.movie.releaseDate??''),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        SizedBox(height: 16),
        BlocConsumer<WatchListViewModel, MoviesState>(
          listener: (context, state) {
            if (state is FinishState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.finishMessage)));
            }
          },
          bloc: viewModel,
          builder: (context, state) {
            if (state is SuccessState) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 150,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15)),
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
                          child:  BookMarkWidget(movie: Movie.fromJson(widget.movie.toJson()),)
                      )
                    ],
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: widget.movie.genres!.map((category) {
                            return CategoryViewWidget(
                                categoryName: category.name ?? "");
                          }).toList(),
                        ),
                        SizedBox(height: 15),
                        AnimatedCrossFade(
                          firstChild: Text(
                            widget.movie.overview ?? AppLocalizations.of(context)!.empty,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          secondChild: Text(
                            widget.movie.overview ?? '',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
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
                          child: Text(
                            isExpanded ? AppLocalizations.of(context)!.less: AppLocalizations.of(context)!.more_read,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
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
                              widget.movie.voteAverage?.toStringAsFixed(1) ??
                                  'N/A',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is ErrorState) {
              return Text(AppLocalizations.of(context)!.some);
            } else if (state is LoadingState) {
              return Center(
                  child: Padding(
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
}
