// import 'package:flutter/material.dart';

// import '../widgets/star_icon.dart';

// class StarCalculator {
//   static List<Widget> getStars(
//       {required double rating, required double starSize}) {
//     List<StarIcon> temp = [];
//     int? y = int.tryParse(rating.toString().split('.')[1]);
//     for (int i = 0; i < rating / 2; i++) {
//       temp.add(StarIcon(
//         icon: Icons.star,
//         size: starSize,
//       ));
//     }
//     if (y != null && y > 5) {
//       temp.add(StarIcon(
//         icon: Icons.star_half,
//         size: starSize,
//       ));
//     }
//     return temp;
//   }
// }
