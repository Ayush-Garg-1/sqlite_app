import 'package:flutter/material.dart';
import 'package:sqlite_intro/database_helper.dart';
import 'package:sqlite_intro/productsDto.dart';

class CustomDropdown extends StatefulWidget {
  Function(List<ProductModel>) getProduct;
  CustomDropdown({required this.getProduct});
  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  List<String> menuItems = ['PRICE(LOWEST)','PRICE(HIGHEST)','A TO Z',
    'Z TO A'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
      PopupMenuButton(
        child:CircleAvatar(
          radius: 25,
          backgroundColor: Colors.orange,
          child: Icon(Icons.filter_list,color: Colors.white,size: 30,),
        ),
        onSelected: (value) async{
         List<ProductModel> productsBasedOnPrice= await DataBaseHelper().getProductBasedOnFilter(
             value);

           List<ProductModel> products=productsBasedOnPrice;
    widget.getProduct(products);
        },
        itemBuilder: (BuildContext context) {
          return
          menuItems.map((String value) {
          return PopupMenuItem(
    value: value.toString(),
    child: Text(
    value.toString(),
    style: TextStyle(fontSize: 15),
    ),
    );

          }).toList();

        },
      )
       //  DropdownButton(
       //    value: selectedItem,
       //    hint: Text("Filters"),
       //    icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
       //    iconSize: 24,
       //    elevation: 16,
       //    style: TextStyle(color: Colors.blue, fontSize: 16),
       //    onChanged: (String? newValue) async {
       //      setState(() {
       //        selectedItem = newValue!;
       //      });
       //      List<ProductModel> productsBasedOnPrice= await DataBaseHelper().getProductBasedOnPrice(
       //          selectedItem!);
       //
       //        List<ProductModel> products=productsBasedOnPrice;
       // widget.getProduct(products);
       //
       //    },
       //    items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
       //      return DropdownMenuItem<String>(
       //        value: value,
       //        child: Text("$value"),
       //      );
       //    }).toList(),
       //  ),
    );
  }
}
