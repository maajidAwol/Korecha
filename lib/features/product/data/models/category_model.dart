import 'package:shop/features/product/domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required String id,
    required String name,
    required String slug,
    required String group,
    required String description,
    String? coverImg,
    required bool isActive,
    List<CategoryModel>? children,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          name: name,
          slug: slug,
          group: group,
          description: description,
          coverImg: coverImg,
          isActive: isActive,
          children: children,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'].toString(),
      name: json['name'],
      slug: json['slug'],
      group: json['group'],
      description: json['description'],
      coverImg: json['coverImg'],
      isActive: json['isActive'],
      children: (json['children'] as List?)
          ?.map((child) => CategoryModel.fromJson(child))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'group': group,
      'description': description,
      'coverImg': coverImg,
      'isActive': isActive,
      'children':
          children?.map((child) => (child as CategoryModel).toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
