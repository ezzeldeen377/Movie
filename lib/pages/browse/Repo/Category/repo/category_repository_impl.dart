import 'package:movie/pages/browse/Models/CategoryResponse.dart';
import 'package:movie/pages/browse/Repo/Category/Category_data_source.dart';
import 'package:movie/pages/browse/Repo/Category/Category_repo_contract.dart';

class CategoryRepositoryImpl implements CategoryRepoContract{
  CategoryDataSource remote;
  CategoryRepositoryImpl({required this.remote});
  @override
  Future<CategoryResponse?> getCategory(String appLanguage) {
 return remote.getCategory(appLanguage);
  }



}