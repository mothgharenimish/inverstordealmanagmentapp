import 'package:flutter/material.dart';
import 'package:investorapp/model/dealmodel.dart';

class DealCard extends StatelessWidget {
  final DealModel deal;
  final VoidCallback? onTap;

  const DealCard({
    super.key,
    required this.deal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding:  EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             SizedBox(height: 3),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20),
               child: Row(
                 children: [
                   Text(
                     deal.companyName,
                     style: const TextStyle(
                       fontSize: 18,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                   Spacer(),
                   Container(
                       padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 6),
                       decoration: BoxDecoration(
                     color: Colors.green,
                       borderRadius: BorderRadius.circular(12),
                     ),
                       child: Text(deal.status,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.white),)
                   )
                 ],
               ),
             ),
             SizedBox(height: 5),
             Padding(
               padding: const EdgeInsets.only(left: 20),
               child: Text(deal.industry,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w800,color: Colors.black ),),
             ),
             SizedBox(height: 5),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20),
               child: Row(
                 children: [


                   Text(deal.investmentINR,style: TextStyle(fontSize: 21,fontWeight: FontWeight.w800,color: Colors.black),),
                   SizedBox(width: 22,),
                   Image.asset("assets/images/icons8-graph-32.png",
                     height: 20,
                     width: 20,
                   ),

                   Text("${deal.roi}%",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w800,color: Colors.green),),

                   Spacer(),
                   Container(
                       padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 6),
                       decoration: BoxDecoration(
                         color: Colors.pink,
                         borderRadius: BorderRadius.circular(12),
                       ),
                       child: Text(deal.risk,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.white),)
                   )
                 ],
               ),
             )
           ],
         ),

        ),
      ),
    );
  }
}