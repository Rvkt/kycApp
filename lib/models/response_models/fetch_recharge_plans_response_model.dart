class FetchRechargePlansModel {
  Map<String, List<PlanDetail>> planDetails;
  Info info;
  String status;

  FetchRechargePlansModel({
    required this.planDetails,
    required this.info,
    required this.status,
  });

}

class Info {
  String infoOperator;
  String circle;
  int productId;
  bool postpaid;
  String source;
  bool status;
  String inCode;
  String outCode;

  Info({
    required this.infoOperator,
    required this.circle,
    required this.productId,
    required this.postpaid,
    required this.source,
    required this.status,
    required this.inCode,
    required this.outCode,
  });

}

class PlanDetail {
  String price;
  String description;
  Talktime talktime;
  String validity;

  PlanDetail({
    required this.price,
    required this.description,
    required this.talktime,
    required this.validity,
  });

}

enum Talktime {
  NA
}
