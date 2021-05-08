import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/news.dart';
import '../../controllers/news_api.dart';
import '../../views/screens/category_details_screen.dart';

class NewsCategory extends StatefulWidget {
  @override
  _NewsCategoryState createState() => _NewsCategoryState();
}

class _NewsCategoryState extends State<NewsCategory> {
  final List<String> newsTabs = [
    'Business',
    'Technology',
    'Entertainment',
    'Health',
    'Sports',
    'Science',
  ];
  String topic = 'Business';
  int _currentColorIndex = 0;
  Future<void> refreshCategoryData() async {
    await fetchAllNews();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshCategoryData,
      child: Column(
        children: [
          Container(
            height: 40,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: newsTabs.length,
                itemBuilder: (ctx, index) {
                  return FlatButton(
                    textColor: _currentColorIndex == index
                        ? Colors.red.shade800
                        : Colors.grey.shade600,
                    onPressed: () {
                      setState(() {
                        topic = newsTabs[index];
                        _currentColorIndex = index;
                      });
                    },
                    child: Text(
                      newsTabs[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  );
                }),
          ),
          FutureBuilder(
              future: fetchTopicsNews(topic),
              builder: (ctx, snapshot) {
                News data = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.error != null) {
                    return Center(
                      child: Text('An error occurred!'),
                    );
                  } else {
                    return Container(
                      height: 500,
                      child: ListView.builder(
                          itemCount: data.articles.length,
                          itemBuilder: (ctx, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CategoryDetailsScreen(
                                              data.articles[index].author,
                                              data.articles[index].description,
                                              data.articles[index].urlToImage,
                                              data.articles[index].publishedAt,
                                              data.articles[index].title,
                                            )));
                              },
                              child: Container(
                                child: ListTile(
                                  leading: (data.articles[index].urlToImage ==
                                          null)
                                      ? Image.asset('images/breaking_news.jpg')
                                      : Hero(
                                          tag:
                                              'heros${data.articles[index].title}',
                                          child: Container(
                                            width: 100,
                                            child: Image.network(
                                              data.articles[index].urlToImage,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                  title: Text(
                                    data.articles[index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  subtitle: Text(
                                    DateFormat('dd/MM/yyyy hh:mm').format(
                                      DateTime.parse(
                                          data.articles[index].publishedAt),
                                    ),
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                }
              }),
        ],
      ),
    );
  }
}
