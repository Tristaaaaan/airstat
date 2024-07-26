class ContinuousDataModel {
  final DateTime dateTime;
  final DateTime lastUpdated;
  final String fileName;
  final String? id1;
  final String? id2;
  final String? id3;
  final String? id4;
  final String mode;
  final String? type;
  final String? readingRows;
  final String? readingPerRows;
  final String? silHeight;
  final String? targetDD;
  final String? targetSide;
  final String? varDD;
  final String? varCD;
  final String? user;
  final int numSampling;
  final int delay;
  final String unit;
  final String? hash;
  final String? asset;
  final String? appVersion;

  final List<String> readings;
  final String? notes;

  ContinuousDataModel({
    required this.dateTime,
    required this.lastUpdated,
    required this.fileName,
    this.id1 = '--.-',
    this.id2 = '--.-',
    this.id3 = '--.-',
    this.id4 = '--.-',
    required this.mode,
    this.type = '--.-',
    this.readingRows = '--.-',
    this.readingPerRows = '--.-',
    this.silHeight = '--.-',
    this.targetDD = '--.-',
    this.targetSide = '--.-',
    this.varDD = '--.-',
    this.varCD = '--.-',
    this.user = 'DefaultUser1',
    required this.numSampling,
    required this.delay,
    required this.unit,
    this.hash = '--.-',
    this.asset = '--.-',
    this.appVersion = '--.-',
    required this.readings,
    this.notes = '--.-',
  });
}
