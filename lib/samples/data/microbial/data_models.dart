class MicroBial {
  final int? id;
  final String? name;
  final String? result;
  final String? unit;
  final String? testlimit;
  final String? method;

  MicroBial(
      {this.id, this.name, this.result, this.unit, this.testlimit, this.method});
  factory MicroBial.fromMap(Map<String, dynamic> json) => MicroBial(
      id: json['id'],
      name: json['name'],
      result: json['result'],
      unit: json['unit'],
      testlimit: json['testlimit'],
      method: json['method']);

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'result':result,
      'unit':unit,
      'testlimit':testlimit,
      'method':method,
    };
  }
}
