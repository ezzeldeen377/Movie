import 'package:movie/pages/browse/Models/CategoryResponse.dart';

abstract class CategoryDataSource{
 Future<CategoryResponse?> getCategory(String appLanguage);
}
