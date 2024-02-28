import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sunmate/localization/demo_localization.dart';
import 'package:sunmate/providers/auth_provider.dart';
import 'package:sunmate/providers/home_provider.dart';
import 'package:sunmate/routes/routes.dart';
import 'package:sunmate/screens/auth/login_page.dart';
import 'package:sunmate/screens/home/home_page.dart';
import 'package:sunmate/themes/theme.dart';
import 'package:velocity_x/velocity_x.dart';
import '../constants/constants.dart';
import 'config/environment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.DEV,
  );
  Environment().initConfig(environment);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findRootAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale = const Locale('en');
  late Auth _auth;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    _auth = Auth();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _auth),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) {
          return Sizer(
            builder: (BuildContext context, Orientation orientation,
                DeviceType deviceType) {
              return MaterialApp(
                localizationsDelegates: const [
                  DemoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                locale: _locale,
                localeListResolutionCallback: (deviceLocale, supportedLocales) {
                  // for (var locale in supportedLocales) {
                  //   if (deviceLocale != null && locale.languageCode == deviceLocale.languageCode &&
                  //       locale.countryCode == deviceLocale.countryCode) {
                  //     return locale;
                  //   }
                  // }
                  // return supportedLocales.first;
                },
                supportedLocales: const [
                  Locale('en'), // English
                  Locale('da'), // Danish
                ],
                title: 'Sunmate.io',
                theme: themedata,
                home: auth.isAuthenticated
                    ? const HomePage()
                    : FutureBuilder(
                  future: auth.autoLogIn(),
                  builder: (ctx, authResultSnapshot) =>
                  authResultSnapshot.connectionState ==
                      ConnectionState.waiting
                      ? Scaffold(
                    backgroundColor: AppColors.backgroundColor,
                    body: const CircularProgressIndicator()
                        .centered(),
                  )
                      : const LoginPage(),
                ),
                routes: allRoutes,
              );
            },
          );
        },
      ),
    );
  }
}
