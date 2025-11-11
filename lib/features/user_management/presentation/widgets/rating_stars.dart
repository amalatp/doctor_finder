import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({super.key, required this.rating});

  final int rating;

  @override
  Widget build(BuildContext context) {
    String stars = '';
    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        stars += '★';
      } else {
        stars += '☆';
      }
    }
    return Text(
      stars,
      style: const TextStyle(color: Colors.amber, fontSize: 14),
    );
  }
}
