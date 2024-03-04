import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunmate/constants/colors_contant.dart';

import '../../constants/constants.dart';
import '../../providers/theme_provider.dart';

class TodayLoadPage extends StatefulWidget {
  const TodayLoadPage({super.key});

  @override
  State<TodayLoadPage> createState() => _TodayLoadPageState();
}

class _TodayLoadPageState extends State<TodayLoadPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Center(
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (ctx, i) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.borderColor),
              ),
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(25),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: getColors(themeNotifier.isDark, 'buttonColor'),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.home_outlined,
                          size: 25,
                          color:
                              getColors(themeNotifier.isDark, 'textColorwhite'),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        '350 W',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color:
                                getColors(themeNotifier.isDark, 'buttonColor')),
                      ),
                      Text(
                        'House Load',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: getColors(
                                themeNotifier.isDark, 'GreyTextColor')),
                      ),
                      Text(
                        'Today 12 kWh',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: getColors(
                                themeNotifier.isDark, 'GreyTextColor')),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          // scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            mainAxisSpacing: 1,
          ),
        ),
      );
    });
  }
}