import 'package:flutter/material.dart';
import '../../../../components/category_loading_card.dart';

Widget buildShimmerCard() {
  return Expanded(
    child: ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return const CategoryLoadingCard();
      },),
  );
}