import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investorapp/bloc/fliterbloc/dealfilter.dart';
import 'package:investorapp/model/dealmodel.dart';
import 'package:investorapp/screen/deal/dealdetails/dealdetails.dart';
import 'package:investorapp/screen/deal/deallisted/dealcard.dart';

class Deallisted extends StatefulWidget {
  const Deallisted({super.key});

  @override
  State<Deallisted> createState() => _DeallistedState();
}

class _DeallistedState extends State<Deallisted> {
  String selectedRisk = "All";
  String selectedIndustry = "All";
  double minRoi = 0;
  double maxRoi = 30;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Investment Deals"),
        actions: [
          IconButton(
            onPressed: () {
              showFilterDialog(context);
            },
            icon: const Icon(Icons.filter_list),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 19, left: 16, right: 16),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.20),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/icons8-search-30.png",
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: _searchController,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          context.read<DealFilter>().searchDeals(value);
                        },
                        decoration: const InputDecoration(
                          hintText: "Search Company",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: BlocBuilder<DealFilter, List<DealModel>>(
              builder: (context, filteredDeals) {
                return ListView.builder(
                  itemCount: filteredDeals.length,
                  itemBuilder: (context, index) {
                    final deal = filteredDeals[index];

                    return DealCard(
                      deal: deal,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Dealdetails(
                              deal: deal,
                              selectedIndex: index,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Filter Deals"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: selectedRisk,
                    isExpanded: true,
                    items: ["All", "Low", "Medium", "High"]
                        .map(
                          (risk) => DropdownMenuItem(
                        value: risk,
                        child: Text(risk),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRisk = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<String>(
                    value: selectedIndustry,
                    isExpanded: true,
                    items: [
                      "All",
                      "Technology",
                      "Fintech",
                      "Healthcare",
                      "Energy",
                      "Retail",
                      "Construction",
                      "Mobility",
                      "Agriculture",
                      "Education"
                    ]
                        .map(
                          (industry) => DropdownMenuItem(
                        value: industry,
                        child: Text(industry),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedIndustry = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Text("ROI: ${minRoi.toInt()}% - ${maxRoi.toInt()}%"),
                  RangeSlider(
                    values: RangeValues(minRoi, maxRoi),
                    min: 0,
                    max: 30,
                    divisions: 6,
                    labels: RangeLabels(
                      minRoi.toInt().toString(),
                      maxRoi.toInt().toString(),
                    ),
                    onChanged: (values) {
                      setState(() {
                        minRoi = values.start;
                        maxRoi = values.end;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.read<DealFilter>().filterDeals(
                  selectedRisk,
                  selectedIndustry,
                  minRoi,
                  maxRoi,
                );

                Navigator.pop(context);
              },
              child: const Text("Apply"),
            ),
            TextButton(
              onPressed: () {
                context.read<DealFilter>().resetDeals();

                setState(() {
                  selectedRisk = "All";
                  selectedIndustry = "All";
                  minRoi = 0;
                  maxRoi = 30;
                  _searchController.clear();
                });

                Navigator.pop(context);
              },
              child: const Text("Reset"),
            )
          ],
        );
      },
    );
  }
}