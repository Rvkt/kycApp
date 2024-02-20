class BankKycResponseModel {
  final String requestId;
  final String mobile;
  final String status;
  final String responseCode;
  final String responseMessage;
  final String otpToken;
  final String? agentId; // agentId can be null

  BankKycResponseModel({
    required this.requestId,
    required this.mobile,
    required this.status,
    required this.responseCode,
    required this.responseMessage,
    required this.otpToken,
    this.agentId,
  });

  factory BankKycResponseModel.fromJson(Map<String, dynamic> json) {
    return BankKycResponseModel(
      requestId: json['requestId'],
      mobile: json['mobile'],
      status: json['status'],
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      otpToken: json['otpToken'],
      agentId: json['agent_id'], // nullable value
    );
  }
}
