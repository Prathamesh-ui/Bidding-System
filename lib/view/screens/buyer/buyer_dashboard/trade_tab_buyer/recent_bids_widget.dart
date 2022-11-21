import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_agri_farmers/constants/colors/constant_colors.dart';
import 'package:e_agri_farmers/helper/print_debug.dart';
import 'package:e_agri_farmers/helper/text_helper.dart';
import 'package:e_agri_farmers/view/screens/buyer/buyer_dashboard/current_logged_buyer/current_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'card/recent_bid_card.dart';
import 'data/recent_bid_data.dart';

class RecentBidsWidget extends StatelessWidget {
  final BuildContext ctx;

  const RecentBidsWidget({Key? key, required this.ctx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [recentBids(), recentBidCards(context)],
    );
  }



  recentBids() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextHelper.textWithColorSize(
                              "Recent Bids", 15, Colors.red,
                              fontWeight: FontWeight.w400),
                          TextHelper.textWithColorSize(
                              "Auctions you have participated in recently",
                              12,
                              Colors.grey),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
          Container(
              margin: const EdgeInsets.all(10),
              child: Divider(
                thickness: 1,
                color: ConstantColors.greyColor2,
              ))
        ],
      ),
    );
  }

  recentBidCards(BuildContext context) {
    return FutureBuilder<List<RecentBidDataBuyer>>(
      future: fetchData(context),
      builder: (context, snapshot) {
    if (snapshot.hasData) {
      List<RecentBidDataBuyer>? data = snapshot.data;
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data?.length,
          itemBuilder: (BuildContext context, int index) {
            return RecentBidCardBuyer(ctx: context, data: data![index]);
          });
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }
    // By default show a loading spinner.
    return Container(
      height: 20,
      width: 20,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        backgroundColor: ConstantColors.mPrimaryColor,
      ),
    );
      },
    );
  }

  static Future<List<RecentBidDataBuyer>> fetchData(
      BuildContext context) async {
    try {
      List<RecentBidDataBuyer> mReturnVal = [];

      await FirebaseFirestore.instance
          .collection("buyers")
          .doc(CurrentBuyerUser.buyerID)
          .collection("bids")
          .get()
          .then((element)  {
        for (var element in element.docs) {
          mReturnVal.add(RecentBidDataBuyer.fromJson(element.data()));
        }
      });

      return mReturnVal;
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No internet Connection"),
      ));
    } catch (e) {
      PP.p("home screen controller error ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Something Went Wrong"),
      ));
    }
    return [];
  }
}
