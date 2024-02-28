import 'package:flutter/cupertino.dart';
import '../../constants/constants.dart';

class CTPVLPage extends StatefulWidget {
  const CTPVLPage({super.key, required this.label});
  final String label;

  @override
  State<CTPVLPage> createState() => _CTPVLPageState();
}

class _CTPVLPageState extends State<CTPVLPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border:
        Border.all(color: AppColors.buttonColor, width: 1),
        // color: AppColors.buttonColor,
      ),
      child: Text(
        widget.label,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: AppColors.buttonColor),
      ),
    );
  }
}
