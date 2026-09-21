import 'package:flutter/material.dart';
import 'package:news/features/home/data/models/source.dart';


class NewTab extends StatelessWidget {
  Source source;
  bool isSelected;
  NewTab({required this.source, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Text(source.name!,
    style: isSelected?textTheme.titleMedium:textTheme.titleSmall,
    
    );
  }
}
