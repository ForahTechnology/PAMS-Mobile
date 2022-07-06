class PhysiCo {
  final int? id;
  final String? name;
  final String? result;
  final String? uc;
  final String? testlimit;
  final String? method;
 

  PhysiCo(
      {this.id, this.name, this.result, this.uc, this.testlimit, this.method});
  factory PhysiCo.fromMap(Map<String, dynamic> json) => PhysiCo(
      id: json['id'],
      name: json['name'],
      result: json['result'],
      uc: json['uc'],
      testlimit: json['testlimit'],
      method: json['method']);

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'result':result,
      'uc':uc,
      'testlimit':testlimit,
      'method':method,
    };
  }
}
