import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_intro/productsDto.dart';



class DataBaseHelper {
  static const String _dbFileName = "ecomapp";
  static Database? _db;
  Future createDbPath() async {
    final String _databaseFilePath;
    Directory _databasePath = await getApplicationDocumentsDirectory();
    _databaseFilePath = join(_databasePath.path, _dbFileName);
    return _databaseFilePath;
  }

  Future getDataBaseFile() async {
    final File _file = File(await createDbPath());
    return _file.path;
  }

  initializeDatabase() async {
      return await openDatabase(
      await getDataBaseFile(),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE products(id INTEGER ,title TEXT ,price NUMERIC,description TEXT,category TEXT,image TEXT)");
      },
   );
  }

  Future<Database> get  getDatabase async {
    if (_db != null) return _db!;
    _db = await initializeDatabase();
    return _db!;
  }

  Future insertProducts(List<ProductModel> products) async{
    Database dbClient = await getDatabase;
    products.forEach((product){
      dbClient.insert("products", product.toJson(product));
    });
  }
  Future<List<ProductModel>> getProductsData() async {
    try {
      Database dbClient = await getDatabase;
      List<Map<String, dynamic>> productsInMap = await dbClient.query("products");

      if (productsInMap.isEmpty) {
        print("No products found in the database.");
        return [];
      }

      List<ProductModel> products = [];
      for (var productMap in productsInMap) {
        try {
          ProductModel product = ProductModel.fromJson(productMap);
          products.add(product);
        }catch (e) {
          print("Error processing product: $e");
        }
      }

      return products;
    } catch (e) {
      print("Error in getProductsData: $e");
      return [];
    }
  }

  Future getProductsCategories() async{
    try{
      Database dbClient = await getDatabase;
      List<Map<String, dynamic>> categories = await
      dbClient.rawQuery
        ("SELECT DISTINCT category FROM products");
      List<String> productsCategories = [];
      categories.forEach((category){
        productsCategories.add(category["category"]);
      });
      productsCategories.insert(0,"all");
      return productsCategories;
    }catch(e){
      print(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryWiseProducts(List<String> categories) async{
    try{
      print(categories);
      Database dbClient = await getDatabase;
      List<Map<String,dynamic>> productsMap=[];
      List<ProductModel> categoriesWiseProducts = [];
      for(int i=0;i<categories.length;i++) {
        if (categories[i] == "all") {
          categoriesWiseProducts=[];
          productsMap = await dbClient.rawQuery("SELECT * FROM products");
          for (var productMap in productsMap) {
            try {
              ProductModel product = ProductModel.fromJson(productMap);
              categoriesWiseProducts.add(product);
            } catch (e) {
              print("Error processing product: $e");
            }
          }
          break;
        }
        else {
          productsMap = await dbClient.rawQuery(
              "SELECT * FROM products WHERE category=?", [categories[i]]);
          for (var productMap in productsMap) {
            try {
              ProductModel product = ProductModel.fromJson(productMap);
              categoriesWiseProducts.add(product);
            } catch (e) {
              print("Error processing product: $e");
            }
          }
        }
      }


      return categoriesWiseProducts;
    }catch(e){
      print(e.toString());
      return [];
    }
  }

  Future getProductBasedOnFilter(String value) async{
    try{
      Database dbClient = await getDatabase;
      List<Map<String,dynamic>> productsMap=[];
    switch(value) {
      case 'PRICE(LOWEST)':
        productsMap =
        await dbClient.rawQuery("SELECT * FROM products ORDER BY price");
        break;
      case 'PRICE(HIGHEST)':
        productsMap =
        await dbClient.rawQuery("SELECT * FROM products ORDER BY price DESC");
        break;
      case 'A TO Z':
        productsMap =
        await dbClient.rawQuery("SELECT * FROM products ORDER BY title");
        break;
      case 'Z TO A':
        productsMap =
        await dbClient.rawQuery("SELECT * FROM products ORDER BY title DESC");
        break;
      default:
        productsMap = await dbClient.rawQuery("SELECT * FROM products");
    }

      List<ProductModel> priceWiseProducts = [];
      for (var productMap in productsMap) {
        try {
          ProductModel product = ProductModel.fromJson(productMap);
          priceWiseProducts.add(product);
        } catch (e) {
          print("Error processing product: $e");
        }
      }

      return priceWiseProducts;
    }catch(e){
      print(e.toString());
      return [];
    }
  }

  Future getProductsBasedOnSearch(String value) async{
    try{
      Database dbClient = await getDatabase;
      List<Map<String,dynamic>> productsMap=[];
      productsMap = await dbClient.rawQuery("SELECT * FROM products WHERE title LIKE '%$value%'",);
      List<ProductModel> priceWiseProducts = [];
      for (var productMap in productsMap) {
        try {
          ProductModel product = ProductModel.fromJson(productMap);
          priceWiseProducts.add(product);
        } catch (e) {
          print("Error processing product: $e");
        }
      }

      return priceWiseProducts;
    }catch(e){
      print(e.toString());
      return [];
    }
  }

  Future getProductBasedOnPriceRange(int price1,int price2) async{
    try{
      Database dbClient = await getDatabase;
      List<Map<String,dynamic>> productsMap=[];
      productsMap = await dbClient.rawQuery
        ("SELECT * FROM products WHERE price >= $price1 AND price <= $price2");
      List<ProductModel> priceWiseProducts = [];
      for (var productMap in productsMap) {
        try {
          ProductModel product = ProductModel.fromJson(productMap);
          priceWiseProducts.add(product);
        } catch (e) {
          print("Error processing product: $e");
        }
      }

      return priceWiseProducts;
    }catch(e){
      print(e.toString());
      return [];
    }
  }

}
