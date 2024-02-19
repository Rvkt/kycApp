class ReportModel {
  int id;
  String operatorName;
  String operatorIncode;
  String operatorOutcode;
  String operatorProviderName;
  int serviceType;
  int apiId;
  bool status;

  ReportModel({
    required this.id,
    required this.operatorName,
    required this.operatorIncode,
    required this.operatorOutcode,
    required this.operatorProviderName,
    required this.serviceType,
    required this.apiId,
    required this.status,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      operatorName: json['operatorName'],
      operatorIncode: json['operatorIncode'],
      operatorOutcode: json['operatorOutcode'],
      operatorProviderName: json['operatorProviderName'],
      serviceType: json['serviceType'],
      apiId: json['apiId'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'operatorName': operatorName,
      'operatorIncode': operatorIncode,
      'operatorOutcode': operatorOutcode,
      'operatorProviderName': operatorProviderName,
      'serviceType': serviceType,
      'apiId': apiId,
      'status': status,
    };
  }
}
