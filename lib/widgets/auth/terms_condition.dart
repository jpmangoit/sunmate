// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../constants/colors_contant.dart';
// import '../../providers/terms_provider.dart';
// import '../../providers/theme_provider.dart';
// import 'package:flutter_html/flutter_html.dart';
//
// class TermsCondition extends StatefulWidget {
//   TermsCondition();
//   @override
//   State<TermsCondition> createState() => _TermsConditionState();
// }
//
// class _TermsConditionState extends State<TermsCondition> {
//   var res;
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       res = Provider.of<Terms>(context, listen: false).terms();
//     });
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ModelTheme>(
//         builder: (context, ModelTheme themeNotifier, child) {
//       return AlertDialog(
//         backgroundColor: getColors(themeNotifier.isDark, 'inputColor'),
//         title: Text('Terms & Conditions',
//             style:
//                 TextStyle(color: getColors(themeNotifier.isDark, 'textColor'))),
//         content: SingleChildScrollView(
//           child: Html(data: res),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Close',
//                 style: TextStyle(
//                     color: getColors(themeNotifier.isDark, 'textColor'))),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     });
//   }
// }
