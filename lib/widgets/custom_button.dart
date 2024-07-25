import 'package:flutter/material.dart';
import 'package:sqlite_intro/constants_variables.dart';

import '../database_helper.dart';
import '../productsDto.dart';

class CustomButton extends StatefulWidget {
  String text;
  Function(List<ProductModel>) getProduct;

  CustomButton({required this.text,required this.getProduct});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  Color color = Colors.orange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
      InkWell(
        onTap: ()async{
          if(!categoriesList.contains(widget.text)){
            categoriesList.add(widget.text);
            List<ProductModel> categoriesWiseproducts = await
            DataBaseHelper().getCategoryWiseProducts(categoriesList);
            widget.getProduct(categoriesWiseproducts);
            if(widget.text=="all"){
              categoriesList.clear();
            }

          }

          setState(() {
            color= Colors.red;
            });
        },
        onDoubleTap: () async{

            categoriesList.remove(widget.text);
            List<ProductModel> categoriesWiseproducts = await
            DataBaseHelper().getCategoryWiseProducts(categoriesList);
            widget.getProduct(categoriesWiseproducts);


          setState(() {
            color= Colors.orange;
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width*0.45,
          height:  MediaQuery.of(context).size.height*0.08,
          decoration: BoxDecoration(
            color: color,
            boxShadow: [
              BoxShadow(color: Colors.white,blurRadius: 5
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.text.toUpperCase(),maxLines: 2,textAlign:TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.white),),
          )),
        ),
      ),
    );


  }
}
