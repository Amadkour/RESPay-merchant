import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/provider/models/shop_product_category_model.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';

class ShopModel extends ParentModel {
  ShopModel({
    List<Shops>? shops,
    List<ShopCategories>? shopCategories,
    List<Banners>? banners,
  }) {
    _shops = shops;
    shopCategories = shopCategories;
    _banners = banners;
  }

  List<Shops>? _shops;
  List<ShopCategories>? shopCategories;
  List<Banners>? _banners;

  List<Shops>? get shops => _shops;

  List<Banners>? get banners => _banners;

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    if (json['shop_categories'] != null) {
      shopCategories = <ShopCategories>[];
      (json['shop_categories'] as List<dynamic>).forEach((dynamic v) {
        shopCategories?.add(ShopCategories.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['banners'] != null) {
      _banners = <Banners>[];
      (json['banners'] as List<dynamic>).forEach((dynamic v) {
        _banners?.add(Banners.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['shops'] != null) {
      _shops = <Shops>[];
      (json['shops'] as List<dynamic>).forEach((dynamic v) {
        String categoryName="";
        shopCategories!.forEach((ShopCategories element) {
          if(element.uuid==(v as Map<String,dynamic>)['shop_category_uuid']){
            categoryName = element.name!;
          }
        });
        _shops?.add(Shops.fromJson(v as Map<String, dynamic>,categoryName: categoryName),);
      });
    }
    return this;
  }
}

class Banners {
  Banners({
    int? id,
    String? uuid,
    String? shopSlug,
    String? image,
    String? title,
    String? body,
    String? url,
    bool? isActive,
  }) {
    _id = id;
    _uuid = uuid;
    _shopSlug = shopSlug;
    _image = image;
    _title = title;
    _body = body;
    _url = url;
    _isActive = isActive;
  }

  Banners.fromJson(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);

    _id = converter.convertToInt(key: 'id');
    _uuid = converter.convertToString(key: 'uuid');
    _shopSlug = converter.convertToString(key: 'shop_slug');
    _image = converter.convertToString(key: 'image');
    _title = converter.convertToString(key: 'title');
    _body = converter.convertToString(key: 'body');
    _url = converter.convertToString(key: 'url');
    _isActive = converter.convertToBool(key: 'is_active');
  }

  int? _id;
  String? _uuid;
  String? _shopSlug;
  String? _image;
  String? _title;
  String? _body;
  String? _url;
  bool? _isActive;

  int? get id => _id;

  String? get uuid => _uuid;

  String? get shopSlug => _shopSlug;

  String? get image => _image;

  String? get title => _title;

  String? get body => _body;

  String? get url => _url;

  bool? get isActive => _isActive;
}

class ShopCategories {
  ShopCategories({
    String? uuid,
    String? name,
  }) {
    _uuid = uuid;
    _name = name;
  }

  ShopCategories.fromJson(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    _name = converter.convertToString(key: 'name');
    _uuid = converter.convertToString(key: 'uuid');
  }

  String? _uuid;
  String? _name;
  bool isSelect = false;

  String? get uuid => _uuid;

  String? get name => _name;
}

class Shops {
  Shops({
    int? id,
    String? uuid,
    String? userUuid,
    String? name,
    String? slug,
    String? description,
    String? icon,
    List<ProductModel>? products,
    String? shopCategoryUuid,
    String? shopCategoryName,
  }) {
    _id = id;
    _uuid = uuid;
    _userUuid = userUuid;
    _name = name;
    _slug = slug;
    _description = description;
    _icon = icon;
    _shopCategoryUuid = shopCategoryUuid;
    _products = products;
    _shopCategoryName = shopCategoryName;
  }

  Shops.fromJson(Map<String, dynamic> json, {String? categoryName}) {
    final FromMap converter = FromMap(map: json);
    _id = converter.convertToInt(key: 'id');
    _uuid = converter.convertToString(key: 'uuid');
    _name = converter.convertToString(key: 'name');
    _slug = converter.convertToString(key: 'slug');
    _shopCategoryUuid = converter.convertToString(key: 'shop_category_uuid');
    _icon = converter.convertToString(key: 'icon');
    _description = converter.convertToString(key: 'description');
    _products = json['products'] != null
        ? converter.convertToListOFModel(
            jsonData: json['products'], modelInstance: ProductModel())
        : null;
    _shopCategoryName = categoryName;
    _categories = converter.convertToListOFModel(
        jsonData: json['categories'], modelInstance: ShopProductCategoryModel());
  }

  int? _id;
  String? _uuid;
  String? _userUuid;
  String? _name;
  String? _slug;
  String? _description;
  String? _icon;
  String? _shopCategoryUuid;
  String? _shopCategoryName;
  List<ProductModel>? _products;

  int? get id => _id;

  String? get uuid => _uuid;

  List<ProductModel>? get products => _products;
  List<ShopProductCategoryModel>? _categories;

  List<ShopProductCategoryModel>? get categories => _categories;

  String? get userUuid => _userUuid;

  String? get name => _name;

  String? get slug => _slug;

  String? get description => _description;

  String? get icon => _icon;

  String? get shopCategoryUuid => _shopCategoryUuid;

  String? get shopCategoryName => _shopCategoryName;
}
