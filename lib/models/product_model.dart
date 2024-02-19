class ProductItemModel {
  int? id;
  String? title;
  String? content;
  String? image;
  String? thumbnail;
  int? userId;

  ProductItemModel(
      {this.id,
        this.title,
        this.content,
        this.image,
        this.thumbnail,
        this.userId});

  ProductItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    thumbnail = json['thumbnail'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    data['thumbnail'] = this.thumbnail;
    data['userId'] = this.userId;
    return data;
  }
}
