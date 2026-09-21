import 'package:flutter/material.dart';

class LoadingIndecator extends StatelessWidget {
  const LoadingIndecator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: Colors.white,),
    );
  }
}
