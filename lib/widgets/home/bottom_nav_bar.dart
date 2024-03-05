import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunmate/constants/colors_contant.dart';
import '../../providers/theme_provider.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Container(
        height: 70,
        decoration: BoxDecoration(
          color: getColors(themeNotifier.isDark, 'backgroundColor'),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1), //(x,y)
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home_outlined),
              color: getColors(themeNotifier.isDark, 'textColor'),
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
    });
  }
}
