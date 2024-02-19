class DthRechargeOperatorModel {
  int id;
  String operatorName;
  String operatorIncode;
  String operatorOutcode;
  String operatorProviderName;
  int serviceType;
  int apiId;
  bool status;

  DthRechargeOperatorModel({
    required this.id,
    required this.operatorName,
    required this.operatorIncode,
    required this.operatorOutcode,
    required this.operatorProviderName,
    required this.serviceType,
    required this.apiId,
    required this.status,
  });

}
