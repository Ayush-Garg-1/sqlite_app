import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String text;
  CustomText({required this.text});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      child: Text(text,maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 16),),
    );
  }
}
