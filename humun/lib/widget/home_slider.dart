import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:humun/models/newsModel.dart';
import 'package:humun/widget/home_news_item.dart';

class NewsSlider extends StatefulWidget {
  const NewsSlider({super.key});

  @override
  State<NewsSlider> createState() => _NewsSliderState();
}

class _NewsSliderState extends State<NewsSlider> {
  late final PageController _pageController;
  int _pageindex = 0;
  late List<NewsModel> _newsList;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1000);
    _loadNewsData();
  }
  Future<void> _loadNewsData() async {
    final String data = await DefaultAssetBundle.of(context).loadString('assets/data/news.json');
    final Map<String, dynamic> jsonData = jsonDecode(data);
    final List<dynamic> articles = jsonData['articles'];

    _newsList = articles.map((article) => NewsModel.fromJSON(article)).toList();

    setState(() {});
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        onPageChanged: (value){
          setState(() {
            _pageindex = value % 5;
          });
        },
        controller: _pageController,
        itemBuilder: (context, index){
          final i = index % 5;
          return HomeNewsSlider(
            isActive: _pageindex == i,
            imageAsset: _newsList.isNotEmpty ? _newsList[i].urlToImage ?? "" : "",
            title: _newsList.isNotEmpty ? _newsList[i].title ?? "" : "",
            author: _newsList.isNotEmpty ? _newsList[i].author ?? "" : "",
            publishedAt: _newsList.isNotEmpty ? _newsList[i].publishedAt ?? "" : "",

          );
        },
      ),

    );
  }
}