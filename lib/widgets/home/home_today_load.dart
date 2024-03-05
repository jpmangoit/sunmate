import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunmate/constants/colors_contant.dart';
import '../../providers/theme_provider.dart';

class TodayLoadPage extends StatefulWidget {
  const TodayLoadPage({super.key});

  @override
  State<TodayLoadPage> createState() => _TodayLoadPageState();
}

class _TodayLoadPageState extends State<TodayLoadPage> {
  var lightIcons = [
    'assets/images/light-icon1.png',
    'assets/images/light-icon2.png',
    'assets/images/light-icon3.png',
    'assets/images/light-icon4.png',
  ];
  var darkIcons = [
    'assets/images/dark-icon1.png',
    'assets/images/dark-icon2.png',
    'assets/images/dark-icon3.png',
    'assets/images/dark-icon4.png',
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Center(
        child: GridView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount:
              themeNotifier.isDark ? darkIcons.length : lightIcons.length,
          itemBuilder: (ctx, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: getColors(themeNotifier.isDark, 'cardborderColor')),
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
                            color:
                                getColors(themeNotifier.isDark, 'buttonColor'),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: themeNotifier.isDark
                              ? Image.asset(
                                  darkIcons[index],
                                  height: 40,
                                  width: 40,
                                )
                              : Image.asset(
                                  lightIcons[index],
                                  height: 45,
                                  width: 45,
                                )),
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
