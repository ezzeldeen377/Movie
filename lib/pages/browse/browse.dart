import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import 'Api/Api_Manager.dart';

import 'Category/Category_details.dart';


class Browse extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {


  @override
  void initState() {
    super.initState();

    // futureSourceRes = ApiManager.get();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
     CategoryDetails()
    );
  }
  Category? selectedCat;
  void onClick(Category newCat){
    selectedCat=newCat;
    setState(() {

    });
  }
}
