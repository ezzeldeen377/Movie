import 'package:movie/pages/browse/CategoryPhoto.dart';

import '../../Models/CategoryResponse.dart';

abstract class Categorystate {}
class LoadingCategoryState extends Categorystate{}
class ErrorCategoryState extends Categorystate{
  String ErrorMessage ;
  ErrorCategoryState({required this.ErrorMessage});
}
class SuccessCategoryState extends Categorystate{
  List<Category> categoryList;
  SuccessCategoryState({required this.categoryList});
}