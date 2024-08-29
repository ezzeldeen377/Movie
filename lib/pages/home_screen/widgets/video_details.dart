import 'package:flutter/material.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/home_screen/model/MovieVideos.dart';
import 'package:timeago/timeago.dart' as timeago;

class VideoDetails extends StatelessWidget {
  final Video video;
  VideoDetails({required this.video});

  @override
  Widget build(BuildContext context) {
    return

      Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  left: 5
                ),
                child: Text(
                  video.name ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                      ),
                  maxLines: 2,
                ),
              ),
            ),
            SizedBox(width: 8), // Adds some space between the two columns
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                right: 5
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Type : ${video.type ?? ''}",
                    style: TextStyle(color: AppColors.whiteColor, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    timeago.format(DateTime.parse(video.publishedAt ?? '')),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12,
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
    );
  }
}
