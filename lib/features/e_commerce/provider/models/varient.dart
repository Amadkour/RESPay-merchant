// ignore_for_file: public_member_api_docs, sort_constructors_first

class Variant {
  final String uuid;
  final String value;
  final String? productVariantId;
  Variant({
    required this.uuid,
    required this.value,
    this.productVariantId,
  });

  factory Variant.fromMap(Map<String, dynamic> map) {
    return Variant(
      uuid: map['uuid'] as String,
      value: map['value'] as String,
      productVariantId: map['productVariantId'] != null ? map['productVariantId'] as String : null,
    );
  }
}
