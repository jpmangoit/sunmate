import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sunmate/constants/colors_contant.dart';
import 'package:sunmate/localization/demo_localization.dart';
import 'package:sunmate/providers/auth_provider.dart';
import 'package:sunmate/providers/home_provider.dart';
import 'package:sunmate/providers/theme_provider.dart';
import 'package:sunmate/routes/routes.dart';
import 'package:sunmate/screens/auth/login_page.dart';
import 'package:sunmate/screens/home/home_page.dart';
import 'package:sunmate/themes/theme.dart';
import 'package:velocity_x/velocity_x.dart';
import '../constants/constants.dart';
import 'config/environment.dart';
import 'package:local_auth/local_auth.dart';

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
  var themeCustom = true;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void _updateThemeBrightness(BuildContext context, ModelTheme themeNotifier) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      themeNotifier.isDark = true;
    } else {
      themeNotifier.isDark = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: Sizer(builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return ChangeNotifierProvider(
          create: (_) => ModelTheme(),
          child: MaterialApp(
            localizationsDelegates: const [
              DemoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: _locale,
            localeListResolutionCallback: (deviceLocale, supportedLocales) {},
            supportedLocales: const [
              Locale('en'), // English
              Locale('da'), // Danish
            ],
            title: 'Sunmate.io',
            // theme: themeNotifier.isDark ? darkThemeData : lightThemeData,
            home: MyHomePage(),
            routes: allRoutes,
          ),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var expireTime;
  var isLogin = false;
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  var authenticationCompleted = false; // Add this flag

  @override
  void initState() {
    checkToken();
    // if (isLogin && !authenticationCompleted) {
    //   _authenticateUser(context);
    // }
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    authenticationCompleted = false;
  }

  Future<Widget> _authenticateUser(BuildContext context) async {
    authenticationCompleted = true;

    bool isAuthenticated = false;

    try {
      isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: 'Authenticate to access the app',
        // Prompt shown to the user
        options: const AuthenticationOptions(
          useErrorDialogs: true, // Show system dialog in case of error

          stickyAuth: true,
        ),
        // Keep the authentication screen open until success or failure
      );
    } catch (e) {
      print('Error: $e');
    }

    if (isAuthenticated) {
      // Navigate to the home screen upon successful authentication
      Navigator.pushNamed(context, '/home');
      return SizedBox();
    } else {
      return SizedBox(); // Return an empty SizedBox when authentication fails
    }
    // else {
    //   Navigator.pop(context);
    // }
  }

  void checkToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    expireTime = prefs.getInt('expire');
    isLogin = prefs.getBool('isLogin') ?? false;

    print('exp$expireTime');
    print('login$isLogin');
    if (expireTime != null) {
      DateTime expirationTime =
          DateTime.now().add(Duration(seconds: expireTime));
      print(expirationTime);
      // Check if the token is expired
      bool isTokenExpired = expirationTime.isBefore(DateTime.now());
      print('$isTokenExpired');
      if (isTokenExpired == true) {
        prefs.remove('isLogin');
        prefs.remove('access_token');
        isLogin = false;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('plog$isLogin');
    return isLogin ? _buildAuthWidget(context) : LoginPage();

    // if (isLogin) {
    //   // Call the content of the authentication dialog function directly
    //   return FutureBuilder(
    //     future: _authenticateUser(context),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         if (snapshot.hasError) {
    //           return Center(
    //             child: Text('Error: ${snapshot.error}'),
    //           );
    //         }
    //         return snapshot.data ?? Container();
    //       } else {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     },
    //   );
    // } else {
    //   // Return login screen
    //   return LoginPage();
    // }
  }

  Widget _buildAuthWidget(BuildContext context) {
    return FutureBuilder(
      future: _authenticateUser(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return snapshot.data ?? Container();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
