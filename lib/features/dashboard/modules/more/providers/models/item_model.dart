class ItemModel {
  String? imageUrl;
  String? text;
  String? color;
  bool? haveSwitch;
  bool? hasBottomSheet;
  bool? haveRightNumber;
  String? navigateTo;
  String? bottomSheetTitle;

  ItemModel({
    required this.imageUrl,
    required this.text,
    this.color,
    this.navigateTo,
    this.haveSwitch,
    this.hasBottomSheet,
    this.haveRightNumber,
    this.bottomSheetTitle,
  });
}
