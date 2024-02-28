import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';

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
    return Container(
      padding: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height *
          0.52, // Adjust the height as needed
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.inputColor,
      ),
      child: ListView(
        children: widget.dataStatistics.entries.map((entry) {
          return Row(
            children: [
              const SizedBox(height: 25,),
              Text(
                "${entry.key}: ${entry.value}",
                style: const TextStyle(color: AppColors.textColor, fontSize: 14,),
              ),

            ],
          );
        }).toList(),
      ),
    );
  }
}
