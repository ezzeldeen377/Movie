import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/core/api/api_constants.dart';
import 'package:movie/core/theme/app_colors.dart';
import 'package:movie/features/home_screen/data/models/movie_response.dart';
import 'package:movie/features/home_screen/presentation/pages/movie_details_view.dart';
import 'package:movie/features/watch_list/presentation/bloc/watch_list_view_model.dart';
import 'package:movie/features/watch_list/presentation/widgets/book_mark_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WatchItem extends StatelessWidget {
  final Movie movie;
  const WatchItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<WatchListViewModel>();

    return SizedBox(
      height: 120.h,
      child: Slidable(
        startActionPane: ActionPane(
            extentRatio: .20,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                onPressed: (context) {
                  viewModel.removeMovieFromFireStore(movie);
                },
                backgroundColor: AppColors.yellowColor,
                foregroundColor: AppColors.blackColor,
                icon: Icons.delete,
                label: AppLocalizations.of(context)!.delete,
                padding: const EdgeInsets.all(10),
              )
            ]),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MovieDetailsView(movieId: movie.id.toString(), movieName: movie.title??'',)));
          },
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: AppColors.blackColor.withOpacity(.8),
                  blurRadius: 10,
                  spreadRadius: 6)
            ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Stack(
                    children: [
                      // Base image
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          child: CachedNetworkImage(
                            imageUrl:
                                ApiConstants.baseImageUrl + movie.posterPath!,
                            placeholder: (context, url) => Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: AppColors.whiteColor,
                                size: 50.h,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width *
                                .3, // Ensures the image covers the entire container// Makes the image fill the height of its container
                            height: MediaQuery.of(context).size.height *
                                .3, // Ensures the image covers the entire container// Makes the image fill the height of its container
                          )),
                      // Overlay icon
                      Positioned(
                          top: -6,
                          left: -7,
                          child: BookMarkWidget(
                            movie: movie,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 200.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        movie.title ?? '',
                        style: TextStyle(color: AppColors.whiteColor),
                        maxLines: 3,
                        softWrap: true,
                      ),
                      Text(
                        movie.overview ?? 'No Title',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 10.h),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ), // movie name
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 20.h,
                            color: AppColors.yellowColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(movie.voteAverage!.toStringAsFixed(1),
                              style: TextStyle(
                                  color: AppColors.whiteColor, fontSize: 12)),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.date_range,
                            size: 17.h,
                            color: AppColors.yellowColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(movie.releaseDate ?? "",
                              style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 12.h)), //relasse data
                        ],
                      ) //actors names
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
}
