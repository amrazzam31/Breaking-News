import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../controllers/news_api.dart';
import '../../models/news.dart';
import '../../views/widgets/news_category.dart';
import '../../views/screens/details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 30, bottom: 10),
            child: Text(
              'Breaking News',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade800),
            ),
          ),
          Column(children: [
            FutureBuilder(
                future: fetchAllNews(),
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
                        height: 380,
                        width: double.infinity,
                        color: Colors.grey.shade100,
                        padding: EdgeInsets.all(16),
                        child: Swiper(
                          itemCount: data.articles.length,
                          autoplay: true,
                          pagination: SwiperPagination(
                            builder: DotSwiperPaginationBuilder(
                                color: Colors.grey,
                                activeColor: Colors.red.shade800,
                                activeSize: 10,
                                size: 8,
                                space: 2),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsScreen(
                                                data.articles[index].author,
                                                data.articles[index]
                                                    .description,
                                                data.articles[index].urlToImage,
                                                data.articles[index]
                                                    .publishedAt,
                                                data.articles[index].title,
                                              )));
                                },
                                child: Hero(
                                  tag: 'hero${data.articles[index].title}',
                                  child: Container(
                                    height: 200,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: (data.articles[index].urlToImage ==
                                              null)
                                          ? Image.asset(
                                              'images/breaking_news.jpg',
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              data.articles[index].urlToImage,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 105,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(children: [
                                    Flexible(
                                      flex: 3,
                                      fit: FlexFit.tight,
                                      child: Text(
                                        data.articles[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.person_outline,
                                                    size: 20),
                                                SizedBox(width: 5),
                                                Text(
                                                  data.articles[index].author
                                                              .length <
                                                          20
                                                      ? data.articles[index]
                                                          .author
                                                      : 'Writer',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              DateFormat('dd/MM/yyyy hh:mm')
                                                  .format(
                                                DateTime.parse(data
                                                    .articles[index]
                                                    .publishedAt),
                                              ),
                                              style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ]),
                                    ),
                                  ]),
                                ),
                              ),
                            ]);
                          },
                        ),
                      );
                    }
                  }
                }),
          ]),
          NewsCategory(),
        ]),
      ),
    );
  }
}
