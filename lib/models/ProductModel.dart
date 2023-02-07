
class ProductModel{
  String? category;
  String? desc;
  String? discount;
  String? image;
  String? name;
  String? popular;
  String? price;
  String? productKey;
  String? wodPrice;
  List<String>? sizes = ["S","M","L","XL","XXL"];
  List<String>? colors = ["black","blue","ref","blue","green","yellow"];

  ProductModel({this.category,this.desc,this.discount,this.image,this.name,this.popular,this.price,this.productKey,this.wodPrice,this.sizes,this.colors});

  factory ProductModel.fromMap(map){
    return ProductModel(
        category: map['category'],
        desc: map['desc'],
        discount: map['discount'],
        image: map["image"],
        name: map["name"],
        popular: map["popular"],
        price: map["price"],
        productKey: map["productKey"],
        wodPrice: map['wodPrice'],
        sizes: map['size'],
        colors: map['color'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'category': category,
      'desc': desc,
      'discount': discount,
      'image': image,
      'name': name,
      'popular': popular,
      'price': price,
      'productKey': productKey,
      'wodprice': wodPrice,
      'color': colors,
      'size': sizes
    };
  }
}