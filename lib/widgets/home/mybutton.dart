import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunmate/providers/theme_provider.dart';

import '../../constants/colors_contant.dart';

class MyButton extends StatelessWidget {
  MyButton({super.key, required this.onTap, required this.text});

  final Function()? onTap;
  final text;
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
      builder: (context, ModelTheme themeNotifier, child) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(15),
            // margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: getColors(themeNotifier.isDark, 'buttonColor'),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: getColors(themeNotifier.isDark, 'buttonTextColor'),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
