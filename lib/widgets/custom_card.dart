import 'package:flutter/material.dart';
import 'package:sqlite_intro/widgets/Card_text.dart';
import 'package:sqlite_intro/productsDto.dart';

class CustomCard extends StatelessWidget {
  ProductModel product;
  CustomCard({required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.45,
      height: MediaQuery.of(context).size.height*0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(product.image.toString(),height: 140,width: 140,),
          ),
          CustomText(text:product.title.toString() ),
          CustomText(text:product.category.toString() ),
          CustomText(text:"Price:${product.price}" ),
        ],),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey,blurRadius: 10
          )
        ],
        borderRadius: BorderRadius.circular(20),
      ),

    );
  }
}
