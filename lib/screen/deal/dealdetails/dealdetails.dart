import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:investorapp/model/dealmodel.dart';
import 'package:investorapp/screen/deal/dealinterest/dealinterested.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dealdetails extends StatelessWidget {
  final DealModel deal;
  final int selectedIndex;

   Dealdetails({
    super.key,
    required this.deal,
    required this.selectedIndex,

  });

  Future<void> saveInterestedDeal() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> oldDeals =
        prefs.getStringList("interestedDeals") ?? [];

    List<DealModel> oldDealList = oldDeals
        .map((e) => DealModel.fromJson(jsonDecode(e)))
        .toList();

    oldDealList.add(deal);

    List<String> updatedDeals = oldDealList
        .map((e) => jsonEncode(e.toJson()))
        .toList();

    await prefs.setStringList("interestedDeals", updatedDeals);
  }

  final TextEditingController _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(deal.companyName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Company Overview",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                deal.companyOverview,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Financial Highlights
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Financial Highlights",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            const SizedBox(height: 10),
            buildHighlightCard("Revenue Growth is 35% YoY"),
            buildHighlightCard("Profit Margin is 18%"),
            buildHighlightCard("Active Merchants is 10,000+"),
            buildHighlightCard("Loan Book Size is ₹50 Cr"),

            const SizedBox(height: 15),

            // ROI Projection
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "ROI Projection",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 20,
                right: 20,
              ),
              child: SizedBox(
                height: 220,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(show: true),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        spots: [
                          const FlSpot(0, 5),
                          const FlSpot(1, 10),
                          const FlSpot(2, 15),
                          FlSpot(3, deal.roi),
                        ],
                        barWidth: 4,
                        dotData: FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Interested Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await saveInterestedDeal();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InterestedList(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: const Color(0xFF228B22),
                  ),
                  child: const Text(
                    "I am interested",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildHighlightCard(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(23),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}