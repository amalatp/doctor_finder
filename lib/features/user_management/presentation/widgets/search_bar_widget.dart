import 'package:doctor_finder/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for a doctor',
          hintStyle: AppStyles.normalTextStyle.copyWith(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: const Icon(Icons.search, color: Colors.black, size: 30),
          border: OutlineInputBorder(
            gapPadding: 10,
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppStyles.mainColor,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}
