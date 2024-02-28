import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../providers/auth_provider.dart';

class MainDrawerPage extends StatefulWidget {
  const MainDrawerPage({super.key});

  @override
  State<MainDrawerPage> createState() => _MainDrawerPageState();
}

class _MainDrawerPageState extends State<MainDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.GreyTextColor,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 15, top: 50, bottom: 20),
            decoration: const BoxDecoration(
              color: AppColors.inputColor,
            ),
            child: Row(
              children: [
                const Text(
                  'Sunmate.io',
                  style: TextStyle(color: AppColors.textColor, fontSize: 20),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Provider.of<Auth>(context, listen: false).logOut();
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  child: const Icon(Icons.logout, color: AppColors.textColor),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Update the UI based on the item selected
              // Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the UI based on the item selected
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
