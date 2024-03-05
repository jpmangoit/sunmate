import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/colors_contant.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/home/mybutton.dart';

class FirstHomePage extends StatefulWidget {
  const FirstHomePage({super.key});

  @override
  State<FirstHomePage> createState() => _FirstHomePageState();
}

class _FirstHomePageState extends State<FirstHomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        backgroundColor: getColors(themeNotifier.isDark, 'backgroundColor'),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Center(
                    child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/${getLogo(themeNotifier.isDark)}',
                  ),
                )),
                SizedBox(
                  height: 25,
                ),
                Center(child: Image.asset('assets/images/home1.png')),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Energy optimization',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                Text(
                  'Sign in to your energy automation app check ',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Sign in to your energy automation app ',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                Text(
                  'energy automation app ',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: MyButton(
                      text: 'Get started',
                      onTap: () {
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
