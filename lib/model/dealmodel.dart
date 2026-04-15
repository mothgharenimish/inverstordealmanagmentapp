class DealModel {
  final String id;
  final String companyName;
  final String industry;
  final double roi;
  final String risk;
  final String status;
  final String companyOverview;
  final String financialHighlights;
  final String riskExplanation;
  final String investmentINR;

  DealModel({
    required this.id,
    required this.companyName,
    required this.industry,
    required this.roi,
    required this.risk,
    required this.status,
    required this.companyOverview,
    required this.financialHighlights,
    required this.riskExplanation,
    required this.investmentINR
  });

  factory DealModel.fromJson(Map<String, dynamic> json) {
    return DealModel(
      id: json['id'],
      companyName: json['companyName'],
      industry: json['industry'],
      roi: json['roi'].toDouble(),
      risk: json['risk'],
      status: json['status'],
      companyOverview: json['companyOverview'],
      financialHighlights: json['financialHighlights'],
      riskExplanation: json['riskExplanation'],
      investmentINR: json['investmentINR']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "companyName": companyName,
      "industry": industry,
      "roi": roi,
      "risk": risk,
      "status": status,
      "companyOverview": companyOverview,
      "financialHighlights": financialHighlights,
      "riskExplanation": riskExplanation,
      "investmentINR": investmentINR,
    };
  }
}