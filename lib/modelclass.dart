class DataView {
  int? connection;
  int? result;
  User? user;

  DataView({this.connection, this.result, this.user});

  DataView.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? iD;
  String? fIRSTNAME;
  String? lASTNAME;
  String? eMAIL;
  String? nUMBER;
  String? pASSWORD;
  String? iMAGEPATH;

  User(
      {this.iD,
      this.fIRSTNAME,
      this.lASTNAME,
      this.eMAIL,
      this.nUMBER,
      this.pASSWORD,
      this.iMAGEPATH});

  User.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    fIRSTNAME = json['FIRSTNAME'];
    lASTNAME = json['LASTNAME'];
    eMAIL = json['EMAIL'];
    nUMBER = json['NUMBER'];
    pASSWORD = json['PASSWORD'];
    iMAGEPATH = json['IMAGEPATH'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['FIRSTNAME'] = this.fIRSTNAME;
    data['LASTNAME'] = this.lASTNAME;
    data['EMAIL'] = this.eMAIL;
    data['NUMBER'] = this.nUMBER;
    data['PASSWORD'] = this.pASSWORD;
    data['IMAGEPATH'] = this.iMAGEPATH;
    return data;
  }
}
