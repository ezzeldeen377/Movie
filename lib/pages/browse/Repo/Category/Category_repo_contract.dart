import 'package:movie/pages/browse/Models/CategoryResponse.dart';

abstract class CategoryRepoContract{
Future<CategoryResponse?>getCategory(String appLanguage);
}