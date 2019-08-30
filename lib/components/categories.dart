class Category {
  final int id;
  final String name;
  final int order;
  final String img;

  Category({this.id, this.name, this.order, this.img});

  factory Category.fromJson(Map<String, dynamic> json) {
    return new Category(
      id: json['id'] as int,
      name: json['name'] as String,
      order: json['order'] as int,
      img: json['img'] as String
    );
  }
}