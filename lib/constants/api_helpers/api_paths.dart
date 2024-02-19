import 'endpoints.dart';

class APIUrl {
  // static const String _baseUrl = "https://m.softmintindia.com/";
  static const String _baseUrl = "http://192.168.1.23:8765/";


  static String authenticateUser = "$_baseUrl${Endpoints.authenticateUser}";
  static String validateToken = "$_baseUrl${Endpoints.validateToken}";

  static String fetchRechargeOperators =
      "$_baseUrl${Endpoints.fetchRechargeOperators}";

  static String fetchDthRechargeOperators = "$_baseUrl${Endpoints.fetchDthRechargeOperators}";

  static String twoFactorLogin = "$_baseUrl${Endpoints.warehouseAeps}";
  static String yesPayouts = "$_baseUrl${Endpoints.yesPayouts}";

  // TODO: yesPayOuts Endpoints
  static String fetchYesPayOutReports = "$_baseUrl${Endpoints.fetchYesPayOutReports}";

  static String nsdlAepsStatusCheck =
      '$_baseUrl${Endpoints.nsdlAepsStatusCheck}';

  static String nsdlAepsreport = '$_baseUrl${Endpoints.nsdlAepsReport}';

  static String initiateRecharge = '$_baseUrl${Endpoints.initiateRecharge}';

  // User related api paths
  static String fetchUserBalance = '$_baseUrl${Endpoints.fetchUserBalance}';
  static String getUserTxnReport = '$_baseUrl${Endpoints.getUserTxnReport}';
  static String getAepsBanks = '$_baseUrl${Endpoints.getAepsBanks}';
  static String getMoveToBankUser = '$_baseUrl${Endpoints.getMoveToBankUser}';
  static String addMoveToBankUser = '$_baseUrl${Endpoints.addMoveToBankUser}';
  static String updateMoveToBankUser = '$_baseUrl${Endpoints.updateMoveToBankUser}';

// Commission related api endpoints
  static String fetchEarningReport = '$_baseUrl${Endpoints.fetchEarningReport}';
  static String fetchChargeByAmount = '$_baseUrl${Endpoints.fetchChargeByAmount}';

//   Recharge related API PATH:
  static String fetchRechargePlans = '$_baseUrl${Endpoints.fetchRechargePlan}';
  // static String fetchNumberPlans = '$_baseUrl${Endpoints.fetchNumberPlan}';
  static String fetchRechargeReports = '$_baseUrl${Endpoints.fetchRechargeReports}';

  // TODO: BBPS API PATHS
  static String fetchBbpsOperators = '$_baseUrl${Endpoints.fetchBbpsOperators}';
  static String fetchViewField = '$_baseUrl${Endpoints.fetchViewField}';
  static String fetchBbpsBill = '$_baseUrl${Endpoints.fetchBbpsBill}';
  static String fetchRechargeField = '$_baseUrl${Endpoints.fetchRechargeField}';
  static String bbpsRecharge = '$_baseUrl${Endpoints.bbpsRecharge}';
  static String bbpsTxnStatus = '$_baseUrl${Endpoints.bbpsTxnStatus}';
  static String warehouseBbpsRecharge = '$_baseUrl${Endpoints.warehouseBbpsRecharge}';
  static String fetchOperatorsByCategory = '$_baseUrl${Endpoints.fetchOperatorsByCategory}';
  static String bbpsReport = '$_baseUrl${Endpoints.bbpsReport}';



  static String initiateAgent = '$_baseUrl${Endpoints.initiateAgent}';
  static String otpCreation = '$_baseUrl${Endpoints.otpCreation}';
}
