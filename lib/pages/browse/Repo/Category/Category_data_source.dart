import 'package:movie/pages/browse/Models/CategoryResponse.dart';

abstract class Online{
 Future<CategoryResponse?> getCategory();
}
