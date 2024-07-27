// ignore_for_file: public_member_api_docs, sort_constructors_first

class AirstatSettingsModel {
  final int delay;
  final int sampling;
  final String unit;

  AirstatSettingsModel({
    required this.delay,
    required this.sampling,
    required this.unit,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'delay': delay,
      'sampling': sampling,
      'unit': unit,
    };
  }
}
