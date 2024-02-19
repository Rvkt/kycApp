class Endpoints {
  static String authenticateUser = "auth/authenticateUser";
  static String validateToken = "auth/validateToken";

  static String fetchRechargeOperators = "operator/fetchOperatorByService/1";

  static String nsdlAepsStatusCheck = 'nsdlaeps/aepsstatuscheck';

  static String nsdlAepsRegister = 'nsdlaeps/register';

  static String warehouseAeps = 'warehouse/aeps';
  static String yesPayouts = 'warehouse/payoutyes';

  // TODO: yesPayOuts Endpoints
  static String fetchYesPayOutReports = 'yespayout/payoutreport';

  static String nsdlAepsKyc = 'nsdlaeps/kyc';

  static String nsdlAepsReport = 'nsdlaeps/aepsreport';



  // User related api endpoints
  static String fetchUserBalance = 'user/fetchUserBalance';
  static String getUserTxnReport = 'user/getTxnReport';
  static String getAepsBanks = 'user/getAepsBanks';
  static String getMoveToBankUser = 'user/getmovetobankuser';
  static String addMoveToBankUser = 'user/addmovetobankuser';
  static String updateMoveToBankUser = 'user/updatemovetobankuser';


  // Recharge related api endpoints
  static String initiateRecharge = 'recharge/recharge';
  static String fetchRechargePlan = 'recharge/fetchRechargePlan';
  // static String fetchNumberPlan = 'recharge/fetchNumberPlan';
  static String fetchRechargeReports = 'rechargeReport/fetchRechargeReport';


  // Commission related endpoint url
  static String fetchEarningReport = 'commission/fetchEarningReport';
  static String fetchChargeByAmount = 'commission/fetchChargeByAmount';

  // TODO: BBPS Endpoints
  static String fetchBbpsOperators = 'operator/fetchOperatorByService/6';
  static String fetchOperatorsByCategory = 'bbps/fetchoperator';
  static String fetchViewField = 'bbps/fetchviewfield';
  static String fetchBbpsBill = 'bbps/viewbill';
  static String fetchRechargeField = 'bbps/fetchrechargefield';
  static String bbpsRecharge = 'bbps/bbpsrecharge';
  static String bbpsTxnStatus = 'bbps/bbpsstatus';
  static String warehouseBbpsRecharge = 'warehouse/bbpsrecharge';
  static String bbpsReport = "bbps/bbpsreport";

  static String fetchDthRechargeOperators = 'operator/fetchOperatorByService/5';

  static String initiateAgent = 'yes/initiateagent';
  static String otpCreation = 'yes/otpcreation';

}
