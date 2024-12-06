import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ArticleDetailsScreen.dart';
import 'OceanDetails.dart';

class Article {
  final String title;
  final String img;
  final String Description;
  final String t1;
  final String d1;

  Article({
    required this.title,
    required this.img,
    required this.Description,
    required this.t1,
    required this.d1,
  });

  factory Article.fromJson(Map<String, dynamic> map) {
    return Article(
      title: map['title'] as String,
      img: map['img'] as String,
      Description: map['Description'] as String,
      t1: map['t1'] as String,
      d1: map['d1'] as String,
    );
  }
}

class GetArticles extends StatefulWidget {
  const GetArticles({super.key});

  @override
  State<GetArticles> createState() => _GeArticles();
}

class _GeArticles extends State<GetArticles> {
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    getFileContent(); // Automatically load data when the widget is initialized
  }

  Future<void> getFileContent() async {
    String content = await rootBundle.loadString("assets/data/articles.json");
    List<dynamic> jsonResponse = jsonDecode(content);
    setState(() {
      articles = jsonResponse.map((oceanJson) => Article.fromJson(oceanJson)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Articles"),
        backgroundColor: Colors.blueAccent,
        elevation: 4.0,
      ),
      body: articles.isEmpty
          ? const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          backgroundColor: Colors.blueAccent,
        ),
      )
          : ListView.builder(
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          final article = articles[index];
          return GestureDetector(
            onTap: () {
              // Navigate to the details screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailsScreen( article: article,),
                ),
              );
            },
            child: Card(
              elevation: 6.0,
              margin: const EdgeInsets.all(12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        article.img,
                        width: 120.0,
                        height: 120.0,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 32.0,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
