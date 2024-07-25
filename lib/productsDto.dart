class ProductModel {
  int? id;
  String? title;
  num? price;
  String? description;
  String? category;
  String? image;
  // Rating? rating;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    // this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> data) {
    return ProductModel(
      id: data['id'],
      title: data['title'],
      price: data['price'],
      description: data['description'],
      category: data['category'],
      image: data['image'],
      // rating: data['rating'] != null ? Rating.fromJson(data['rating']) : null,
    );
  }

  Map<String, dynamic> toJson(ProductModel data) {
    return {
      "id": data.id,
      "title": data.title,
      "price": data.price,
      "description": data.description,
      "category": data.category,
      "image": data.image,
      // "rating": data.rating!.toJson(data.rating!)
    };
  }
}

// class Rating {
//   num? rate;
//   int? count;
//
//   Rating({this.rate, this.count});
//
//   factory Rating.fromJson(Map<String, dynamic>? data) {
//     if (data == null) return Rating(rate: null, count: null);
//
//     return Rating(
//       rate: data['rate'],
//       count: data['count'],
//     );
//   }
//
//   Map<String, dynamic> toJson(Rating data) {
//     return {
//       "rate": data.rate,
//       "count": data.count,
//     };
//   }
// }
