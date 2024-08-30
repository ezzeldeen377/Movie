import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchField extends StatelessWidget {
  final TextEditingController _searchController;
  final Function(String) onChanged;
  final Function() onPreesd;
   SearchField({
    required TextEditingController searchController,
    required this.onChanged,
     required this.onPreesd,
    Key? key,
  })  : _searchController = searchController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      child: TextField(
        autofocus: true,
        controller: _searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.darkGrayColor,
          hintText:AppLocalizations.of(context)!.search.toLowerCase()+'...' ,
          hintStyle: TextStyle(color: AppColors.whiteColor,fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(Icons.search, color: AppColors.whiteColor),
          suffixIcon:
               IconButton(
            icon: Icon(Icons.cancel, color: Colors.white),
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
