import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunmate/constants/colors_contant.dart';

import '../../constants/constants.dart';
import '../../main.dart';
import '../../models/language.dart';

class LanguageSelect extends StatefulWidget {
  const LanguageSelect({super.key});

  @override
  State<LanguageSelect> createState() => _LanguageSelectState();
}

class _LanguageSelectState extends State<LanguageSelect> {
  var themeCustom = "dark";
  void _changeLanguage(Language language) {
    print(language.flage);
    Locale _temp;
    switch (language.languageCode) {
      case 'en':
        _temp = Locale(language.languageCode, "US");
        break;
      case 'da':
        _temp = Locale(language.languageCode, "DA");
        break;
      default:
        _temp = Locale(language.languageCode, "US");
    }

    MyApp.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: AppColors.inputColor,
      underline: SizedBox(),
      onChanged: (Language? language) {
        if (language != null) {
          _changeLanguage(language);
        }
      },
      icon: Icon(Icons.language, color: getColors(themeCustom, 'textColor')),
      items: Language.languageList()
          .map<DropdownMenuItem<Language>>(
            (lang) => DropdownMenuItem<Language>(
              value: lang,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(lang.flage,
                      style: TextStyle(
                          color: getColors(themeCustom,
                              'textColor'))), // corrected from lang.flage to lang.flag
                  Text(lang.name,
                      style: TextStyle(
                          color: getColors(themeCustom, 'textColor'))),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
