// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class CategoryTypeModel extends Equatable {
  final String name;
  final String? icon;
  final String slug;
  final String uuid;
  final int id;
  const CategoryTypeModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.slug,
    required this.uuid,
  });

  factory CategoryTypeModel.fromMap(Map<String, dynamic> map) {
    return CategoryTypeModel(
      id: map['id'] as int,
      name: map['name'] as String,
      icon: map['icon'] as String?,
      slug: map['slug'] as String,
      uuid: map['uuid'] as String,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        name,
        icon,
        slug,
        uuid,
      ];
}
