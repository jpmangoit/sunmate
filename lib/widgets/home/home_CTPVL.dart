import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunmate/constants/colors_contant.dart';
import 'package:sunmate/widgets/home/CTPCL.dart';
import '../../constants/constants.dart';
import '../../providers/theme_provider.dart';

class HomeCTPVPage extends StatefulWidget {
  const HomeCTPVPage({super.key, required this.heading});
  final String heading;
  @override
  State<HomeCTPVPage> createState() => _HomeCTPVPageState();
}

class _HomeCTPVPageState extends State<HomeCTPVPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.29,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderColor),
          ),
          
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.heading,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: getColors(themeNotifier.isDark, 'textColor'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CTPVLPage(
                      label: 'L1:369 A',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CTPVLPage(
                      label: 'L1:369 A',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CTPVLPage(
                      label: 'L1:369 A',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
