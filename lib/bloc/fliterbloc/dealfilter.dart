import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investorapp/model/dealmodel.dart';
import 'package:investorapp/screen/deal/dealdata.dart';

class DealFilter extends Cubit<List<DealModel>> {
  DealFilter() : super(mockDeals);

  List<DealModel> deals = mockDeals;

  void filterDeals(String risk, String industry, double minRoi, double maxRoi) {
    List<DealModel> filteredDeals = [];

    for (var deal in deals) {
      bool riskMatch = risk == "All" || deal.risk == risk;
      bool industryMatch = industry == "All" || deal.industry == industry;
      bool roiMatch = deal.roi >= minRoi && deal.roi <= maxRoi;

      if (riskMatch && industryMatch && roiMatch) {
        filteredDeals.add(deal);
      }
    }

    emit(filteredDeals);
  }

  void searchDeals(String query) {
    List<DealModel> searchList = [];

    for (var deal in deals) {
      if (deal.companyName.toLowerCase().contains(query.toLowerCase())) {
        searchList.add(deal);
      }
    }

    emit(searchList);
  }

  void resetDeals() {
    emit(deals);
  }
}