import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/app_colors.dart';
import 'package:movie/pages/search/Cubit/search_cubit.dart';

class SearchField extends StatelessWidget {
  final TextEditingController _searchController;
  final Function(String) onChanged;

  const SearchField({
    required TextEditingController searchController,
    required this.onChanged,
    Key? key,
  })  : _searchController = searchController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40,horizontal: 10),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.darkGrayColor,
          hintText: 'Search..', // Arabic for 'Search...'
          hintStyle: TextStyle(color: AppColors.whiteColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(Icons.search, color: AppColors.whiteColor),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.cancel, color: Colors.white),
            onPressed: () {
              _searchController.clear();
              context.read<SearchCubit>().search('');
            },
          )
              : null,
        ),
        style: TextStyle(color: AppColors.whiteColor),
        onChanged: onChanged,
      ),
    );
  }
}
