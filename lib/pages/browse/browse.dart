import 'package:flutter/material.dart';
import 'package:movie/pages/home_screen/api/api_manager.dart';

class Browse extends StatefulWidget {
  @override
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiManager.getMoreLikeThis('1160018');
  }

  @override
  Widget build(BuildContext context) {
    return  Container(color: Colors.blue,);
  }
}