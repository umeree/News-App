
import 'package:newsappflutter/model/categories_news_model.dart';
import 'package:newsappflutter/repositories/news_repository.dart';

import '../model/headlines_news_model.dart';

class NewsViewModel {
  final _api = NewsRepository();

  Future<HeadlinesNewsModel> fetchNewsChannelHeadlineApi(String channelName) async {
    final response = await _api.fetchNewsChannelHeadlineApi(channelName);
    return response;
  }


  Future<CategoriesNewsModel> fetchCetegoryNewsApi(String category) async {
    final response = await _api.fetchCategoryNewsApi(category);
    return response;
  }
}