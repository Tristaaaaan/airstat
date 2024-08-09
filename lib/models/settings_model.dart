// ignore_for_file: public_member_api_docs, sort_constructors_first

class AirstatSettingsModel {
  final int sampling;
  final int ventSampling;
  final int delay;
  final int ventDelay;
  final String unit;
  final String username;

  AirstatSettingsModel({
    required this.delay,
    required this.sampling,
    required this.unit,
    required this.username,
    required this.ventDelay,
    required this.ventSampling,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'delay': delay,
      'sampling': sampling,
      'unit': unit,
      'username': username,
      'vent_delay': ventDelay,
      'vent_sampling': ventSampling
    };
  }

  factory AirstatSettingsModel.fromMap(Map<String, dynamic> map) {
    return AirstatSettingsModel(
      delay: map['delay'] as int,
      sampling: map['sampling'] as int,
      unit: map['unit'] as String,
      username: map['username'] as String,
      ventDelay: map['vent_delay'] as int,
      ventSampling: map['vent_sampling'] as int,
    );
  }
}
