import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
  String text;

  VoidCallback onPressed;
  DefaultElevatedButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width, 56)
      ),
      
      onPressed: onPressed, child: Text(text,
    style: Theme.of(context).textTheme.titleLarge
    
    ));
  }
}
