import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sunmate/providers/auth_provider.dart';
import 'package:sunmate/providers/home_provider.dart';
import 'package:sunmate/routes/routes.dart';
import 'package:sunmate/screens/auth/login_page.dart';
import 'package:sunmate/screens/home/home_page.dart';
import 'package:sunmate/themes/theme.dart';
import 'package:velocity_x/velocity_x.dart';
import '../constants/constants.dart';
import 'config/environment.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.DEV,
  );
  Environment().initConfig(environment);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) {
          return Sizer(
            builder: (BuildContext context, Orientation orientation,
                DeviceType deviceType) {
              return MaterialApp(
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
