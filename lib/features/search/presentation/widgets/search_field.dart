import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchField extends StatelessWidget {
  final TextEditingController _searchController;
  final Function(String) onChanged;
  final Function() onPreesd;
    const SearchField({
    required TextEditingController searchController,
    required this.onChanged,
     required this.onPreesd,
    super.key,
  })  : _searchController = searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 10.w),
      child: TextField(
        autofocus: true,
        controller: _searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.darkGrayColor,
          hintText:AppLocalizations.of(context)!.search.toLowerCase()+'...' ,
          hintStyle: TextStyle(color: AppColors.whiteColor,fontSize: 16.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0.r),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(Icons.search, color: AppColors.whiteColor),
          suffixIcon:
               IconButton(
            icon: const Icon(Icons.cancel, color: Colors.white),
            onPressed: () {
              onPreesd.call();
            },
          ),
        ),
        style: TextStyle(color: AppColors.whiteColor),
        onChanged: onChanged,
      ),
    );
  }
}
