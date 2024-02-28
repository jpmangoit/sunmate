import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class TodayLoadPage extends StatefulWidget {
  const TodayLoadPage({super.key});

  @override
  State<TodayLoadPage> createState() => _TodayLoadPageState();
}

class _TodayLoadPageState extends State<TodayLoadPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (ctx, i) {
          return Card(
            color: AppColors.inputColor,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
                          color: AppColors.buttonColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.home_outlined,
                          size: 20,
                          color: AppColors.GreyTextColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '350 W',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.buttonColor),
                      ),
                      const Text(
                        'House Load',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: AppColors.GreyTextColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 1,
          mainAxisExtent: 150,
        ),
      ),
    );
  }
}
