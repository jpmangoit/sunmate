import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunmate/constants/colors_contant.dart';
import '../../constants/constants.dart';

class TodayStaticsticsPage extends StatefulWidget {
  const TodayStaticsticsPage({Key? key, required this.dataStatistics})
      : super(key: key);
  final Map<String, String> dataStatistics;
  @override
  State<TodayStaticsticsPage> createState() => _TodayStaticsticsPageState();
}

class _TodayStaticsticsPageState extends State<TodayStaticsticsPage> {
  var themeCustom = "dark";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: widget.dataStatistics.entries.map((entry) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor),
            ),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Text(
                  entry.key,
                  style: TextStyle(
                    color: getColors(themeCustom, 'textColor'),
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Text(
                  entry.value,
                  style: TextStyle(
                    color: getColors(themeCustom, 'textColor'),
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
