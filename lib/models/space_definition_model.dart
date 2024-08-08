class Configuration {
  int? id;
  String id1;
  String id2;
  String id3;
  String id4;
  String units;
  String mode;
  String? type;
  int? xRows;
  int? yReadPerRow;
  int? zSilWidth;
  int? silHeight;
  int? targetDd;
  int? targetSide;
  int? varDd;
  int? varCd;
  int? tbd1;
  int? tbd2;

  Configuration({
    this.id,
    required this.id1,
    required this.id2,
    required this.id3,
    required this.id4,
    required this.units,
    required this.mode,
    this.type,
    this.xRows,
    this.yReadPerRow,
    this.zSilWidth,
    this.silHeight,
    this.targetDd,
    this.targetSide,
    this.varDd,
    this.varCd,
    this.tbd1,
    this.tbd2,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID1': id1,
      'ID2': id2,
      'ID3': id3,
      'ID4': id4,
      'Units': units,
      'Mode': mode,
      'Type': type,
      'X_Rows': xRows,
      'Y_ReadPerRow': yReadPerRow,
      'Z_Sil_Width': zSilWidth,
      'Sil_Height': silHeight,
      'Target_DD': targetDd,
      'Target_side': targetSide,
      'Var_DD': varDd,
      'Var_CD': varCd,
      'tbd1': tbd1,
      'tbd2': tbd2,
    };
  }

  factory Configuration.fromMap(Map<String, dynamic> map) {
    return Configuration(
      id: map['id'] as int,
      id1: map['ID1'] as String,
      id2: map['ID2'] as String,
      id3: map['ID3'] as String,
      id4: map['ID4'] as String,
      units: map['Units'] as String,
      mode: map['Mode'] as String,
      type: map['Type'] != null ? map['Type'] as String : null,
      xRows: map['X_Rows'] != null ? map['X_Rows'] as int : null,
      yReadPerRow:
          map['Y_ReadPerRow'] != null ? map['Y_ReadPerRow'] as int : null,
      zSilWidth: map['Z_Sil_Width'] != null ? map['Z_Sil_Width'] as int : null,
      silHeight: map['Sil_Height'] != null ? map['Sil_Height'] as int : null,
      targetDd: map['Target_DD'] != null ? map['Target_DD'] as int : null,
      targetSide: map['Target_side'] != null ? map['Target_side'] as int : null,
      varDd: map['Var_DD'] != null ? map['Var_DD'] as int : null,
      varCd: map['Var_CD'] != null ? map['Var_CD'] as int : null,
      tbd1: map['tbd1'] != null ? map['tbd1'] as int : null,
      tbd2: map['tbd2'] != null ? map['tbd2'] as int : null,
    );
  }
}
