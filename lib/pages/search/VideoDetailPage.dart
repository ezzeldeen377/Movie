import 'package:flutter/material.dart';
import 'package:movie/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:movie/pages/search/CustomClipper.dart';
import 'package:movie/pages/search/model/SourcesMovie.dart';

class VideoDetailPage extends StatefulWidget {
  final Results movie;

  VideoDetailPage({required this.movie});

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> iconAnimation;
  late Animation<double> textAnimation;
  late Animation<double> imageOpacityAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    iconAnimation = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticInOut,
      ),
    );

    textAnimation = Tween<double>(
      begin: -30.0,
      end: 30.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    imageOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = '';
    if (widget.movie.releaseDate != null && widget.movie.releaseDate!.isNotEmpty) {
      DateTime releaseDate = DateTime.parse(widget.movie.releaseDate!);
      formattedDate = DateFormat('d MMMM yyyy').format(releaseDate);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.movie.title ?? 'Video details',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.whiteColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          if (widget.movie.posterPath != null)
            Stack(
              children: [
                ClipPath(
                  // clipper: DiagonalClipper(),
                  child: AnimatedBuilder(
                    animation: imageOpacityAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: imageOpacityAnimation.value,
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
                          fit: BoxFit.cover,
                          height: 250.0,
                          width: double.infinity,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: AnimatedBuilder(
                    animation: iconAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, iconAnimation.value),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                              size: 40,
                            ),
                            onPressed: () {
                              ///لو نعمل اي حاجه هنا
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          SizedBox(height: 16),
          AnimatedBuilder(
            animation: textAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, textAnimation.value),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.movie.title ?? 'No address',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: textAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, textAnimation.value),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Release Date: $formattedDate',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 17,
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: textAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, textAnimation.value),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.movie.overview ?? 'There is no summary',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 19,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
