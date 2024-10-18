class ProductModel {
  String? name;
  String? description;
  String? image;
  int? price;
  int? oldPrice;
  int? id;
  int? discount;

  ProductModel.fromJson({required Map<String, dynamic> data}) {
    name = data['name'];
    description = data['description'].toString();
    price = data['price'] is int
        ? data['price']
        : int.tryParse(data['price'].toString());
    oldPrice = data['old_price'] is int
        ? data['old_price']
        : int.tryParse(data['old_price'].toString());
    id = data['id'] is int ? data['id'] : int.tryParse(data['id'].toString());
    discount = data['discount'] is int
        ? data['discount']
        : int.tryParse(data['discount'].toString());
    image = data['image'].toString();
  }
}
