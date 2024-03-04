import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunmate/constants/colors_contant.dart';
import 'package:sunmate/localization/demo_localization.dart';
import 'package:sunmate/main.dart';
import 'package:sunmate/models/language.dart';
import 'package:sunmate/widgets/home/bottom_nav_bar.dart';
import 'package:sunmate/widgets/home/home_CTPVL.dart';
import 'package:sunmate/widgets/home/home_chart.dart';
import 'package:sunmate/widgets/home/home_today_load.dart';
import 'package:sunmate/widgets/home/todays_staticstics.dart';
import 'package:sunmate/widgets/layouts/main_drawer.dart';
import 'package:sunmate/widgets/shared/language_select.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../constants/constants.dart';
import '../../localization/localization_contants.dart';
import '../../providers/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Initial Selected Value
  String dropdownvalue = 'Power Slit';
  var themeCustom = "dark";

  // List of items in our dropdown menu
  var items = [
    'Power Slit',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  Map<String, String> DataStaticstics = {
    'Houseload': '165 W',
    'Solar Production': '652 W',
    'Grid Load Watt': '652 W',
    'Battery Soc': '652 W',
    'Battery Load Watt': '652 W',
    'Inverter Serial': '652 W',
    'Inverter Datalogger Last Updated': '652 W',
    'Inverter Status': '652 W',
    'Current Power Price': '652 W',
    'Todays Production': '652 W',
    'Todays Battery Charge': '652 W',
    'Todays Solar Sell': '652 W',
    'Todays Grid usage': '652 W',
  };

  bool isSwitched = false;
  bool isSwitchedSolerSell = true;

  void _toggleSolerSwitch(bool value) {
    setState(() {
      isSwitchedSolerSell = value;
    });
  }

  void _toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: getColors(themeCustom, 'textColor'), // Change your color here
        ),
        backgroundColor: getColors(themeCustom, 'backgroundColor'),
        centerTitle: true,
        title: Text(
          getTranslated(context, 'k_home_page'),
          textAlign: TextAlign.center,
          style: TextStyle(color: getColors(themeCustom, 'textColor')),
        ),
        actions: const <Widget>[
          Padding(padding: EdgeInsets.all(5), child: LanguageSelect())
        ],
      ),
      backgroundColor: getColors(themeCustom, 'backgroundColor'),
      resizeToAvoidBottomInset: true,
      drawer: const MainDrawerPage(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, 'k_home_load_info'),
                    style:
                        TextStyle(color: getColors(themeCustom, 'textColor')),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                            color: getColors(themeCustom, 'textColorblack')),
                        color: getColors(themeCustom, 'dropdownColor')),
                    child: DropdownButton(
                      // isExpanded: true,
                      dropdownColor: getColors(themeCustom, 'dropdownColor'),
                      style: TextStyle(
                          color: getColors(themeCustom, 'textColorblack'),
                          fontSize: 12),
                      value: dropdownvalue,
                      isDense: true,
                      underline: const SizedBox(),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: getColors(themeCustom, 'textColorblack'),
                      ),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              HomeChartPage(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, 'k_home_today_load'),
                    style:
                        TextStyle(color: getColors(themeCustom, 'textColor')),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const TodayLoadPage(),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  HomeCTPVPage(heading: "Internal CT"),
                  HomeCTPVPage(heading: "External CT"),
                  HomeCTPVPage(heading: "PV"),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, 'k_home_today_statistics'),
                    style:
                        TextStyle(color: getColors(themeCustom, 'textColor')),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TodayStaticsticsPage(dataStatistics: DataStaticstics),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarPage(),
    );
  }
}
