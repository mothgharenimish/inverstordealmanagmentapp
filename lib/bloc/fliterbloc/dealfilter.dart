import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investorapp/model/dealmodel.dart';
import 'package:investorapp/screen/deal/dealdata.dart';

class DealFilter extends Cubit<List<DealModel>> {
  DealFilter() : super(mockDeals);

  final List<DealModel> allDeals = mockDeals;

  void filterDeals({
    required String risk,
    required String industry,
    required double minRoi,
    required double maxRoi,
  }) {
    final filtered = allDeals.where((deal) {
      final riskMatch = risk == "All" || deal.risk == risk;
      final industryMatch =
          industry == "All" || deal.industry == industry;
      final roiMatch = deal.roi >= minRoi && deal.roi <= maxRoi;

      return riskMatch && industryMatch && roiMatch;
    }).toList();

    emit(filtered);
  }

  void searchDeals(String query) {
    final filtered = allDeals.where((deal) {
      return deal.companyName
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();

    emit(filtered);
  }

  void resetDeals() {
    emit(allDeals);
  }
}