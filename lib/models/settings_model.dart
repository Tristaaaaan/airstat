

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

  factory AirstatSettingsModel.fromMap(Map<String, dynamic> map) {
    return AirstatSettingsModel(
      delay: map['delay'] as int,
      sampling: map['sampling'] as int,
      unit: map['unit'] as String,
    );
  }

}
