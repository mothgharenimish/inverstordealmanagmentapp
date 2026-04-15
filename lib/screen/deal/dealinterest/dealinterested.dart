import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:investorapp/model/dealmodel.dart';
import 'package:investorapp/screen/deal/dealinterest/interestedcard.dart';

class InterestedList extends StatefulWidget {
  const InterestedList({super.key});

  @override
  State<InterestedList> createState() => _InterestedListState();
}

class _InterestedListState extends State<InterestedList> {
  List<DealModel> interestedDeals = [];

  @override
  void initState() {
    super.initState();
    loadDeals();
  }

  Future<void> loadDeals() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> savedDeals =
        prefs.getStringList("interestedDeals") ?? [];

    setState(() {
      interestedDeals = savedDeals
          .map((e) => DealModel.fromJson(jsonDecode(e)))
          .toList();
    });
  }

  Future<void> removeDeal(int index) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      interestedDeals.removeAt(index);
    });

    final updatedList = interestedDeals
        .map((deal) => jsonEncode(deal.toJson()))
        .toList();

    await prefs.setStringList(
      "interestedDeals",
      updatedList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Interested List"),
      ),
      body: ListView.builder(
        itemCount: interestedDeals.length,
        itemBuilder: (context, index) {
          return Interestedcard(
            deal: interestedDeals[index],
            onTap: () {
              removeDeal(index);
            },
          );
        },
      ),
    );
  }
}