import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunmate/constants/colors_contant.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';

class MainDrawerPage extends StatefulWidget {
  const MainDrawerPage({super.key});

  @override
  State<MainDrawerPage> createState() => _MainDrawerPageState();
}

class _MainDrawerPageState extends State<MainDrawerPage> {
  bool? isSwitched;

  @override
  void initState() {
    storage();
    // TODO: implement initState
    super.initState();
  }

  void storage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitched = prefs.getBool('isLogin') ?? false;
    });
    print('storage');
  }

  var set;
  void _toggleSwitch(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isSwitched = value;
    await prefs.setBool('isLogin', isSwitched!);
    set = prefs.getBool('isLogin');
    print('value$isSwitched');
    print('local$set');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Drawer(
        backgroundColor: getColors(themeNotifier.isDark, 'GreyTextColor'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 15, top: 50, bottom: 20),
              decoration: BoxDecoration(
                color: getColors(themeNotifier.isDark, 'inputColor'),
              ),
              child: Row(
                children: [
                  Text(
                    'Sunmate.io',
                    style: TextStyle(
                        color: getColors(themeNotifier.isDark, 'textColor'),
                        fontSize: 20),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      Provider.of<AuthProvider>(context, listen: false).logOut();
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    child: Icon(Icons.logout,
                        color: getColors(themeNotifier.isDark, 'textColor')),
                  ),
                ],
              ),
            ),
            Switch(
              value: isSwitched ?? false,
              onChanged: _toggleSwitch,
              activeTrackColor: Colors.grey,
              activeColor: Colors.grey.shade700,
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
    });
  }
}
