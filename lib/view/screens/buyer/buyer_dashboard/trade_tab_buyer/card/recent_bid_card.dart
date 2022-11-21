import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/router/route_paths.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/trade_tab_buyer/data/recent_bid_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentBidCardBuyer extends StatelessWidget {
  final BuildContext ctx;
  final RecentBidDataBuyer data;
  const RecentBidCardBuyer({Key? key , required this.ctx,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.pushNamed(ctx, RoutePaths.recentBidsBuyer , arguments: {"data" : data}),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextHelper.textWithColorSize("Farmer Phone :  " + data.auctionId.substring(0 , 13) , 15 , Colors.blue , fontWeight: FontWeight.w400),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: ConstantColors.mPrimaryColor,borderRadius: const BorderRadius.all(Radius.circular(5))),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),

                      child:TextHelper.textWithColorSize("LIVE" , 8 , Colors.white),
                    )
                  ],
                )
              ],
            ),
            TextHelper.textWithColorSize("Farmer Name :  " + data.farmerName, 15 , Colors.blue , fontWeight: FontWeight.w400),
            const SizedBox(height: 5,),
            TextHelper.textWithColorSize(data.cropName , 16 , Colors.green ,fontWeight: FontWeight.w500),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child:TextHelper.textWithColorSize(
                  "Address : ${data.village}, ${data.district}, ${data.state}", 15 , Colors.black),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextHelper.textWithColorSize("", 15, Colors.green),
                  Row(
                    children: [
                      TextHelper.textWithColorSize("Recent Bid", 14, Colors.blue , fontWeight: FontWeight.w500)
                    ],
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: ConstantColors.greyColor2,
            )
          ],
        ),
      )
    );
  }
}
