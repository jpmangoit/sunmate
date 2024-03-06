import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/colors_contant.dart';
import '../../providers/terms_provider.dart';
import '../../providers/theme_provider.dart';
import 'package:flutter_html/flutter_html.dart';

class TermsCondition extends StatefulWidget {
  TermsCondition();
  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  late String res = ""; // Specify the type of res

  @override
  void initState() {
    super.initState();
    _loadTerms(); // Call the function to load terms
  }

  Future<void> _loadTerms() async {
    res = await Terms().terms();
    if (mounted) {
      setState(() {}); // Refresh the UI once data is loaded
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<ModelTheme>(
      builder: (context, ModelTheme themeNotifier, child) {
        if (res.isEmpty) {
          // Display a loading indicator while data is being fetched
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // Once data is loaded, display the AlertDialog
          return AlertDialog(
            backgroundColor: getColors(themeNotifier.isDark, 'inputColor'),
            content: SizedBox(
              width: width * 0.8, // adjust width as needed
              height: height * 0.8, // adjust height as needed
              child: SingleChildScrollView(
                child: Html(
                  data: res, // Use res directly here
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Close',
                    style: TextStyle(
                        color: getColors(themeNotifier.isDark, 'textColor'))),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      },
    );
  }
}
