import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/theme/app_colors.dart';
import 'package:movie/features/home_screen/data/models/MovieVideos.dart';
import 'package:timeago/timeago.dart' as timeago;

class VideoDetails extends StatelessWidget {
  final Video video;
  const VideoDetails({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkGrayColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, left: 5),
                  child: Text(
                    video.name ?? '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14.h,
                        ),
                    maxLines: 2,
                  ),
                ),
              ),
              const SizedBox(
                  width: 8), // Adds some space between the two columns
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Type : ${video.type ?? ''}",
                      style:
                          TextStyle(color: AppColors.whiteColor, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      timeago.format(DateTime.parse(video.publishedAt ?? '')),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 12.h,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
