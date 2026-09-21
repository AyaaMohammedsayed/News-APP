import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/core/constants/api_constants.dart';
import 'package:news/features/home/data/models/news_response.dart';
import 'package:news/features/home/data/models/sources_response.dart';




class ApiService {
  static Future <SourcesResponse>getSources(String catId) async {
    Uri uri = Uri.https(ApiConstants.baseUrl, ApiConstants.sourcesEndPoint, {
      'apiKey': ApiConstants.apiKey,
      'category': catId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return SourcesResponse.fromJson(json);
  }
  static Future<NewsResponse>getNews(String sourceId) async {
    Uri uri = Uri.https(ApiConstants.baseUrl, ApiConstants.newsEndPoint, {
      'apiKey': ApiConstants.apiKey,
      'sources': sourceId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return NewsResponse.fromJson(json);
  }
}
