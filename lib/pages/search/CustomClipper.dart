import 'package:flutter/material.dart';

// Custom clipper for a stylish diagonal clipping
class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height - 60); // Diagonal line
    path.lineTo(size.width - 30, size.height); // Diagonal line to bottom right
    path.lineTo(size.width, 0); // Vertical line to top right
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
