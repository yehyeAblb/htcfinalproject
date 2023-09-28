class ProductModel {
  String? id;
  String? name;
  num? price;
  String? description;
  List<dynamic>? images;

  ProductModel({this.id, this.name, this.price, this.description, this.images});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['id'] = id;
    json['name'] = name;
    json['price'] = price;
    json['description'] = description;
    json['images'] = images;
    return json;
  }
}
