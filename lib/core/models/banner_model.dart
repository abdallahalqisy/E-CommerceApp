class BannerModel {
  String? url;
  int? id;

  BannerModel.fromJson({required Map<String, dynamic> data}) {
    url = data['image'];
    id = data['id'];
  }
}
