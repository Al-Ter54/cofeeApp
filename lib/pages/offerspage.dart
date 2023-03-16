import 'dart:ui';

import 'package:flutter/material.dart';

import '../items/offeritem.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [
      OfferItem(
        title: "First Offer",
        description: "First Descr",
      ),
      OfferItem(
        title: "First Offer",
        description: "First Descr",
      ),
      OfferItem(
        title: "First Offer",
        description: "First Descr",
      ),
      OfferItem(
        title: "First Offer",
        description: "First Descr",
      ),
      OfferItem(
        title: "First Offer",
        description: "First Descr",
      ),
      OfferItem(
        title: "First Offer",
        description: "First Descr",
      ),
      OfferItem(
        title: "First Offer",
        description: "First Descr",
      ),
      OfferItem(
        title: "First Offer",
        description: "First Descr",
      ),
      OfferItem(
        title: "First Offer",
        description: "First Descr",
      ),
      OfferItem(
        title: "First Offer",
        description: "First Descr",
      ),
    ]);
  }
}
