import 'package:movie/pages/browse/Models/CategoryResponse.dart';
import 'package:movie/pages/browse/Repo/Category/Category_data_source.dart';
import 'package:movie/pages/browse/Repo/Category/Category_repo_contract.dart';

class SourceRepoImpl implements CategoryRepoContract{
  Online remote;
  SourceRepoImpl({required this.remote});
  @override
  Future<CategoryResponse?> getCategory() {
 return remote.getCategory();
  }



}