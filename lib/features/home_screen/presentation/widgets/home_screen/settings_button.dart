import 'package:flutter/material.dart';
import 'package:movie/core/common/screens/settings.dart';
import 'package:movie/core/theme/app_colors.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 30,
        left: 0,
        child: SizedBox(
          width: 55.0, // Set width of the button
          height: 45.0, // Set height of the button
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingScreen()));
            },
            foregroundColor: AppColors.blackColor,
            backgroundColor: const Color(0xFFFFBB3B), // Background color
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), // Border radius for top right
                bottomRight:
                    Radius.circular(20), // Border radius for bottom right
                topLeft: Radius.circular(0), // No border radius for top left
                bottomLeft:
                    Radius.circular(0), // No border radius for bottom left
              ),
            ),
            child: const Icon(Icons.settings, size: 30), // Settings icon
          ),
        ),
      );
  }
}