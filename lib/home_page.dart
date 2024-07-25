import 'package:flutter/material.dart';
import 'package:sqlite_intro/widgets/custom_button.dart';
import 'package:sqlite_intro/widgets/custom_card.dart';
import 'package:sqlite_intro/widgets/custom_dropdown.dart';
import 'package:sqlite_intro/productsDto.dart';
import 'package:sqlite_intro/widgets/custom_searchbar.dart';
import 'database_helper.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = [];
  bool isLoading = true;


  getProductData()async{
    try{
      products = await DataBaseHelper().getProductsData();
      setState(() {
        isLoading=false;
      });
    }catch(e){
      isLoading=true;
      print(e.toString());
    }
  }
  double lowerValue = 0.0;
  double upperValue = 1500.0;

  @override
  void initState() {
    super.initState();
    getProductData();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(height: 10,),
           Container(
             width: MediaQuery.of(context).size.width,
             padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),

             child: Row(
               children: [
                 CustomSearchBar(getProducts: (List<ProductModel> productBasedOnSearch){
                   setState(() {
                     products = productBasedOnSearch;
                   });
                 },),
                 SizedBox(width: 20,),
                 CustomDropdown(getProduct: (List<ProductModel> priceWiseProducts){
                   setState(() {
                     products = priceWiseProducts;
                   });
                 },),
               ],
             ),
           ),
            Container(
              width: MediaQuery.of(context).size.width*0.6,
              child: Center(
                child: RangeSlider(
                  activeColor: Colors.orange,
                  inactiveColor: Colors.orange.withOpacity(0.3),
                  values: RangeValues(lowerValue, upperValue),
                  labels: RangeLabels(
                  '$lowerValue',
                  '$upperValue',
                ),
                  min: 0,
                    max: 1500,
                    divisions: 150,
                    onChanged: (val) async{
                      setState(() {
                        lowerValue = val.start;
                        upperValue = val.end;
                      });

                  List<ProductModel> priceWiseProducts = await DataBaseHelper().getProductBasedOnPriceRange(val.start.round(), val.end.round());
                setState(() {
                  products = priceWiseProducts;
                });
                }, ),
              ),
            ),
            SizedBox(height: 10,),
            FutureBuilder(
              future: DataBaseHelper().getProductsCategories(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  List<String> categories = snapshot.data;
                  return Center(
                    child: Wrap(
                      children: categories.map((category){
                        return  CustomButton(text: category,getProduct:
                            (List<ProductModel>categoriesWiseproducts){
                          setState(() {
                           products = categoriesWiseproducts;
                          });
                        },);

                      }).toList()
                      ,),
                  );
                }else{
                  return Center(child: CircularProgressIndicator(color: Colors.orange,));
                }
              },

            ),
            SizedBox(height: 20,),
            isLoading ? Center(child: CircularProgressIndicator(color: Colors.orange,)):
            Center(
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 20,
                runSpacing: 20,
                children:
                products.map((product){
                  return
                    CustomCard(product: product,);
                }).toList(),
              ),
            ),
          ],
        )
      ),
    );
  }
}
