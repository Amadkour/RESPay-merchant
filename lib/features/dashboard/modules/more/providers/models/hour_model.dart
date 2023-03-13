class HourModel{
  int ?id;

  HourModel({required this.isAvailable,required this.id, required this.hour, required this.type});

  bool isAvailable;
  int ?hour;
  String ?type;
}
