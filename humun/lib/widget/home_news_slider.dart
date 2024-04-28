import 'package:flutter/material.dart';
import 'package:humun/theme.dart';// Assuming you have the icons imported

class HomeNewsSlider extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String author;
  final String publishedAt;

  const HomeNewsSlider({
    Key? key,
    required this.imageAsset,
    required this.title,
    required this.author,
    required this.publishedAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageAsset,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200.0,
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(Icons.person, size: 18.0),
                      SizedBox(width: 4.0),
                      Text(
                        author,
                        style: TextStyle( fontWeight: FontWeight.bold,)
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 18.0),
                      SizedBox(width: 4.0),
                      Text(
                        publishedAt,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }
}
