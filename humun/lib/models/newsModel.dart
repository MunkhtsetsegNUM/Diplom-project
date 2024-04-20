import 'package:json_annotation/json_annotation.dart';

part 'newsModel.g.dart';

@JsonSerializable(createToJson: false)
class NewsModel {
  String? title;
  String? imageUrl;
  String? author;
  String? description;
  String? content;
  String? urlToImage;
  String? publishedAt;

  NewsModel({
    this.title, 
    this.imageUrl,
    this.author,
    this.description,
    this.content,
    this.urlToImage,
    this.publishedAt});

    factory NewsModel.fromJSON(Map<String, dynamic> json) => _$NewsModelFromJson(json);
    Map<String, dynamic> toJson (){throw UnimplementedError();}


}