import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Center(
                child: Image.asset(
              'assets/images/logo1.png',
              // height: height * 0.12,
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
            MyButton(
              text: 'Get started',
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
          ],
        ),
      ),
    );
  }
}
