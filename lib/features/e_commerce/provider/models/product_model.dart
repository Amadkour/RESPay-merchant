import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/varient.dart';

class ProductModel extends ParentModel {
  String? id;
  String name;
  String slug;
  String categoryName;
  List<String> images;
  String thumbImage;
  List<ProductCategory>? categories;
  late String? _cartUUID;

  String get cartUUID => _cartUUID!;

  set cartUUID(String value) {
    _cartUUID = value;
  }

  double? salesPrice;
  String? description;
  bool isPublished;
  int count;
  double price;
  bool isFav = false;
  bool isInCart;
  final int quantity;
  List<ProductModel> similarProduct;

  double get discountPercentage {
    return (price - (salesPrice ?? 0)) / price;
  }

  Map<String, List<Variant>> variants;

  ProductModel({
    this.id,
    this.name = '',
    this.categories,
    this.categoryName = "",
    this.images = const <String>[],
    this.similarProduct = const <ProductModel>[],
    this.salesPrice,
    this.description,
    this.count = 0,
    this.price = 0,
    this.isFav = false,
    this.isInCart = false,
    this.variants = const <String, List<Variant>>{},
    this.isPublished = true,
    this.quantity = 0,
    this.slug = '',
    this.thumbImage = '',
  });

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    final FromMap convert = FromMap(map: map);
    final double salePrice = convert.convertToDouble(key: 'sale_price', defaultValue: 0) ?? 0;
    final double price = convert.convertToDouble(key: 'price', defaultValue: 0) ?? 0;
    return ProductModel(
      id: convert.convertToString(key: 'uuid'),
      name: convert.convertToString(key: 'name') ?? "",
      categoryName: convert.convertToString(key: 'category') ?? "",
      description: convert.convertToString(key: 'description'),
      images: convert.convertToListOFString(map['images']),
      count: convert.convertToInt(key: 'count') ?? 0,
      isFav: convert.convertToBool(key: 'is_favorite') ?? false,
      isInCart: convert.convertToBool(key: 'isInCard') ?? false,
      price: price,

      /// TODO REMOVED WHEN FIXED FROM BACKEND
      salesPrice: salePrice == 0 ? price : salePrice,

      isPublished: convert.convertToBool(key: 'is_published') ?? false,
      quantity: convert.convertToInt(key: 'quantity') ?? 0,
      slug: convert.convertToString(key: "slug") ?? "",
      thumbImage: convert.convertToString(key: "thumb_image") ?? "",
      categories: convert.convertToListOFModel(modelInstance: ProductCategory(), jsonData: map['categories']),
      variants: map['product_variants'] != null
          ? map['product_variants'] is! List<dynamic>
              ? Map<String, List<Variant>>.from(
                  (map['product_variants'] as Map<String, dynamic>).map(
                    (String key, dynamic value) => MapEntry<String, List<dynamic>>(
                      key,
                      (value as List<dynamic>).map((dynamic e) => Variant.fromMap(e as Map<String, dynamic>)).toList(),
                    ),
                  ),
                )
              : <String, List<Variant>>{}
          : <String, List<Variant>>{},
      similarProduct: convert.convertToListOFModel(
        jsonData: map['otherProducts'],
        modelInstance: ProductModel(),
      ),
    );
  }

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    return ProductModel.fromJson(
      json,
    );
  }
}

class ProductCategory extends ParentModel {
  int? id;
  String? uuid;
  String? name;

  ProductCategory({this.id, this.uuid, this.name});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return ProductCategory(
      id: converter.convertToInt(key: "id"),
      uuid: converter.convertToString(key: "uuid"),
      name: converter.convertToString(key: "name"),
    );
  }
}
