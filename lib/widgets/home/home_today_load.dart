import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunmate/constants/colors_contant.dart';
import '../../providers/theme_provider.dart';

class TodayLoadPage extends StatefulWidget {
  TodayLoadPage(
      {required this.name,
        required this.watt,
        required this.forecast,
        required this.usage,
        required this.img});
  var watt;
  var forecast;
  var usage;
  var name;
  var img;
  @override
  State<TodayLoadPage> createState() => _TodayLoadPageState();
}

class _TodayLoadPageState extends State<TodayLoadPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
          return Container(
            width: width * 0.4,
            height: height * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: getColors(themeNotifier.isDark, 'cardborderColor')),
            ),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(15),
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
                        child: Image.asset(
                          widget.img,
                          height: 40,
                          width: 40,
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      '${widget.watt.toString()} W',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: getColors(themeNotifier.isDark, 'buttonColor')),
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: getColors(themeNotifier.isDark, 'GreyTextColor')),
                    ),
                    Text(
                      '${widget.forecast.toString()}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: getColors(themeNotifier.isDark, 'GreyTextColor')),
                    ),
                    Text(
                      '${widget.usage.toString()}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: getColors(themeNotifier.isDark, 'GreyTextColor')),
                    ),
                  ],
                ),
              ],
            ),
          );

          // scrollDirection: Axis.horizontal,
        });
  }
}
