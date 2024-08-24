import 'package:flutter/material.dart';
import 'package:movie/pages/search/VideoDetailPage.dart';
import 'package:movie/pages/search/api/api_manager.dart';
import 'package:movie/pages/search/model/SourcesMovie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie/app_colors.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<Results> _results = [];
  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadSearchQuery();
  }

  Future<void> _loadSearchQuery() async {
    final prefs = await SharedPreferences.getInstance();
    final savedQuery = prefs.getString('search_query') ?? '';
    _searchController.text = savedQuery;
    if (savedQuery.isNotEmpty) {
      _performSearch(savedQuery);
    }
  }

  Future<void> _saveSearchQuery(String query) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('search_query', query);
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _results = [];
        _hasError = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final response = await ApiManager.searchNews(query);
      if (response != null) {
        setState(() {
          _results = response.results ?? [];
        });
        _saveSearchQuery(query); // Save the query to SharedPreferences
      }
    } catch (e) {
      setState(() {
        _hasError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _clearSearch() {
    _searchController.clear();
    _performSearch('');
  }

  void _onMovieTap(Results movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoDetailPage(movie: movie), ///***show details Screen here ******
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.06),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.darkGrayColor,
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: AppColors.whiteColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: AppColors.whiteColor),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.cancel, color: Colors.white),
                    onPressed: _clearSearch,
                  )
                      : null,
                ),
                style: TextStyle(color: AppColors.whiteColor),
                onChanged: (query) {
                  _performSearch(query);
                },
              ),
            ),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : _results.isEmpty
                ? Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageIcon(
                      AssetImage('assets/icons/icon_background.png'),
                      color: AppColors.whiteColor,
                      size: MediaQuery.of(context).size.height * 0.08,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No results found',
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ],
                ),
              ),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  final movie = _results[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    color: AppColors.darkGrayColor,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8.0),
                      leading: movie.posterPath != null
                          ? Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        width: 80,
                        fit: BoxFit.cover,
                      )
                          : SizedBox(width: 80),
                      title: Text(
                        movie.title ?? 'No Title',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        movie.overview ?? 'No Overview',
                        style: TextStyle(color: AppColors.whiteColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      isThreeLine: true,
                      onTap: () => _onMovieTap(movie),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
