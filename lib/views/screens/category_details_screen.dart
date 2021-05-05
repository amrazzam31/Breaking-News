import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String title;
  final String author;
  final String time;
  final String description;
  final String image;

  CategoryDetailsScreen(
      this.author, this.description, this.image, this.time, this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 15, top: 30, bottom: 10, right: 15),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.blue.shade800,
                size: 30,
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: (image == null)
                    ? Image.asset(
                        'images/breaking_news.jpg',
                        fit: BoxFit.cover,
                      )
                    : Hero(
                        tag: 'heros$title',
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  Icon(Icons.person_outline),
                  SizedBox(width: 5),
                  Text(
                    author.length > 20 ? 'Writer' : author,
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                DateFormat('dd/MM/yyyy hh:mm').format(
                  DateTime.parse(time),
                ),
                style: TextStyle(
                    color: Colors.grey.shade700, fontWeight: FontWeight.bold),
              ),
            ]),
            SizedBox(height: 15),
            Text(
              description,
              style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
            ),
            Text(''),
          ]),
        ),
      ),
    );
  }
}
