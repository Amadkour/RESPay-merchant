import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class FavoritesModel extends ParentModel {
  String? message;
  Favorites? favorites;

  FavoritesModel({this.message, this.favorites});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return FavoritesModel(
        message: converter.convertToString(key: "message"),
        favorites: json['favorites'] is! List<dynamic>
            ? Favorites().fromJson(json['favorites'] as Map<String, dynamic>)
            : Favorites(
                items: <FavoriteItemModel>[],
              ));
  }
}

class Favorites {
  int? id;
  String? uuid;
  String? userUuid;
  List<FavoriteItemModel>? items;

  Favorites({this.id, this.uuid, this.userUuid, this.items});

  Favorites fromJson(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return Favorites(
        id: converter.convertToInt(key: "id"),
        uuid: converter.convertToString(key: "uuid"),
        userUuid: converter.convertToString(key: "user_uuid"),
        items: converter.convertToListOFModel(
            jsonData: json['items'], modelInstance: FavoriteItemModel()));
  }
}

class FavoriteItemModel extends ParentModel {
  String? uuid;
  String? slug;
  String? name;
  String? description;
  double? price;
  double? offerPrice;
  String? isPublished;
  List<String>? image;

  FavoriteItemModel(
      {this.uuid,
      this.slug,
      this.name,
      this.description,
      this.price,
      this.offerPrice,
      this.isPublished,
      this.image});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return FavoriteItemModel(
      uuid: converter.convertToString(key: "uuid"),
      slug: converter.convertToString(key: "slug"),
      name: converter.convertToString(key: "name"),
      description: converter.convertToString(key: "description"),
      price: converter.convertToDouble(key: "price"),
      offerPrice: converter.convertToDouble(key: "offer_price"),
      isPublished: converter.convertToString(key: "is_published"),
      image: converter.convertToListOFString(json['image']),
    );
  }
}
