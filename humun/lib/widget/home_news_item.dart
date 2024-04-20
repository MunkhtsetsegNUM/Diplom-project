
import 'package:flutter/material.dart';
import 'package:humun/theme.dart';

class HomeNewsSlider extends StatelessWidget {
  final bool isActive;
  final String imageAsset;
  final String title;
  final String author;
  final String publishedAt;


  const HomeNewsSlider({
    super.key, 
    required this.isActive,
    required this.imageAsset,
    required this.title,
    required this.author,
    required this.publishedAt,
    });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.07,
      child: AnimatedScale(
        duration: const Duration(microseconds: 400),
        scale: isActive ? 1: 0.8,
        child:ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                color: Colors.red,
              ),
              Image.network(
                imageAsset,
                fit: BoxFit.cover,
                height: double.maxFinite,
                width: double.maxFinite,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      black01,
                      black02,
                      black03
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      author,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              )
            ]
          ),
          
          
        )
      )
     ) ;
  }
}