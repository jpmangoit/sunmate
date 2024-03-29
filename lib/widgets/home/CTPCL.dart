import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../constants/colors_contant.dart';
import '../../providers/theme_provider.dart';

class CTPVLPage extends StatefulWidget {
  const CTPVLPage({super.key, required this.label});
  final String label;

  @override
  State<CTPVLPage> createState() => _CTPVLPageState();
}

class _CTPVLPageState extends State<CTPVLPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
          return Container(
            // width: MediaQuery.of(context).size.width * 0.2,
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                  color: getColors(themeNotifier.isDark, 'buttonColor'), width: 1),
            ),
            child: Text(
              widget.label,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: getColors(themeNotifier.isDark, 'buttonColor')),
            ),
          );
        });
  }
}
