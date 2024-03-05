import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunmate/constants/colors_contant.dart';
import '../../constants/constants.dart';
import '../../providers/theme_provider.dart';

class TodayStaticsticsPage extends StatefulWidget {
  const TodayStaticsticsPage({Key? key, required this.dataStatistics})
      : super(key: key);
  final Map<String, String> dataStatistics;
  @override
  State<TodayStaticsticsPage> createState() => _TodayStaticsticsPageState();
}

class _TodayStaticsticsPageState extends State<TodayStaticsticsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: widget.dataStatistics.entries.map((entry) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: getColors(themeNotifier.isDark, 'borderColor')),
              ),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              padding: const EdgeInsets.all(13),
              child: Row(
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(
                        color: getColors(themeNotifier.isDark, 'GreyTextColor'),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  const Spacer(),
                  Text(
                    entry.value,
                    style: TextStyle(
                      color: getColors(themeNotifier.isDark, 'textColor'),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
