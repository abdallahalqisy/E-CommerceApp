class CategoryModel {
  String? url;
  int? id;
  String? title;
  CategoryModel.fromJson({required Map<String, dynamic> data}) {
    url = data['image'];
    id = data['id'];
    title = data['name'];
  }
}
