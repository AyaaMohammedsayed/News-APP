import 'package:flutter/material.dart';
import 'package:news/core/Theme/app_theme.dart';
import 'package:news/features/home/data/models/article.dart';

import 'package:timeago/timeago.dart' as timeago;

class NewItem extends StatelessWidget {
  Article news;
   NewItem({required this.news});

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.white),
      ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
  (news.urlToImage != null && news.urlToImage!.trim().isNotEmpty)
      ? news.urlToImage!
      : 'https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=600&auto=format&fit=crop',
  width: MediaQuery.sizeOf(context).width,
  height: MediaQuery.sizeOf(context).height * 0.25,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) {
    return Image.network(
      'https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=600&auto=format&fit=crop',
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.25,
      fit: BoxFit.cover,
    );
  },
),),
          SizedBox(height: 10),
          Text(
            news.title!,
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("By: ${news.source!.name!}", style: textTheme.labelSmall),
              Text('${timeago.format(news.publishedAt!)}', style: textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}
