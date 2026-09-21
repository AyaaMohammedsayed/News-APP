import 'package:flutter/material.dart';
import 'package:news/core/Theme/app_theme.dart';

class DefaultElevatedButton extends StatelessWidget {
  final String text; 
  final VoidCallback onPressed;

  const DefaultElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width, 56),
        backgroundColor: AppTheme.black,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppTheme.white),
      ),
    );
  }
}