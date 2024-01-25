import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsappflutter/model/categories_news_model.dart';
import 'package:newsappflutter/model/headlines_news_model.dart';
class NewsRepository {
  Future<HeadlinesNewsModel> fetchNewsChannelHeadlineApi(String channelName) async {
    String url = "https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=c6bd3250290e47769612d8a641b4cbf9";
    print(url);
    final response = await http.get(Uri.parse(url));
    // print(response.body);
   if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return HeadlinesNewsModel.fromJson(body);
   }
   else {
     throw Exception("Error");
   }
  }

  Future<CategoriesNewsModel> fetchCategoryNewsApi(String category) async {
    String url = "https://newsapi.org/v2/everything?q=${category}&apiKey=c6bd3250290e47769612d8a641b4cbf9";
    print(url);
    final response = await http.get(Uri.parse(url));
    // print(response.body);
    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    else {
      throw Exception("Error");
    }
  }
}