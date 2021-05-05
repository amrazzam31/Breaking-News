import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/news.dart';

String apiKey = '5b342720ab7d492eb7137f764638f737';
Future<News> fetchAllNews() async {
  final url = 'https://newsapi.org/v2/everything?q=Egypt&apiKey=$apiKey';
  http.Response response = await http.get(url);

  final data = jsonDecode(response.body);
  return News.fromJson(data);
}

Future<News> fetchTopicsNews(String topic) async {
  final url = 'https://newsapi.org/v2/everything?q=$topic&apiKey=$apiKey';
  http.Response response = await http.get(url);

  final data = jsonDecode(response.body);
  return News.fromJson(data);
}
