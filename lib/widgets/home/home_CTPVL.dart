import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunmate/widgets/home/CTPCL.dart';
import '../../constants/constants.dart';

class HomeCTPVPage extends StatefulWidget {
  const HomeCTPVPage({super.key,required this.heading});
final String heading;
  @override
  State<HomeCTPVPage> createState() => _HomeCTPVPageState();
}

class _HomeCTPVPageState extends State<HomeCTPVPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.29,
      child: Card(
        color: AppColors.inputColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment:  MainAxisAlignment.center,
                children: [
                  Text(
                    widget.heading,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CTPVLPage(label: 'L1:369 A',),
                  const SizedBox(
                    height: 5,
                  ),
                  CTPVLPage(label: 'L1:369 A',),
                  const SizedBox(
                    height: 5,
                  ),
                  CTPVLPage(label: 'L1:369 A',),
                  const SizedBox(
                    height: 5,
                  ),
                ],

              ),
            ],
          ),
        ),
      ),
    );
  }
}
