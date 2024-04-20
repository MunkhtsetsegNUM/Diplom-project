import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:humun/models/newsModel.dart';
import 'package:humun/widget/home_news_slider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late List<NewsModel> _newsList = [];

  @override
  void initState() {
    super.initState();
    _loadNewsData();
  }

  Future<void> _loadNewsData() async {
    final String data =
        await DefaultAssetBundle.of(context).loadString('assets/data/news.json');
    final Map<String, dynamic> jsonData = jsonDecode(data);
    final List<dynamic> articles = jsonData['articles'];

    _newsList =
        articles.map((article) => NewsModel.fromJSON(article)).toList();

    setState(() {});
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/image/news.png",
                  width: 100,
                ),
              ],
            ),
          ),
          Expanded(
            child: _newsList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _newsList.length,
                  itemBuilder: (context, index) {
                    return HomeNewsSlider(
                      imageAsset: _newsList[index].urlToImage ?? "",
                      title: _newsList[index].title ?? "",
                      author: _newsList[index].author ?? "",
                      publishedAt: _newsList[index].publishedAt ?? "",
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
