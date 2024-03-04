import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunmate/constants/colors_contant.dart';

import '../../constants/constants.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  var themeCustom = "dark";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: AppColors.inputColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.home_outlined),
            color: getColors(themeCustom, 'textColor'),
            onPressed: () {
              // Handle home icon press
            },
          ),
          IconButton(
            icon: const Icon(Icons.electric_meter_outlined),
            onPressed: () {
              // Handle power icon press
            },
          ),
          IconButton(
            icon: const Icon(Icons.library_books_outlined),
            onPressed: () {
              // Handle list icon press
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {
              // Handle profile icon press
            },
          ),
        ],
      ),
    );
  }
}
