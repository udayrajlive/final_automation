import 'package:final_automation/SelecionarDispositivo.dart';
import 'package:final_automation/SplashScreen.dart';
import 'package:final_automation/onBoarding.dart';
import 'package:flutter/material.dart'

    show BuildContext, MaterialApp, StatelessWidget, Widget, runApp;

import 'package:provider/provider.dart';
import 'HomePage.dart';
import 'provider/StatusConexaoProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

        providers: [
          ChangeNotifierProvider<StatusConexaoProvider>.value(
              value: StatusConexaoProvider()),
        ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Automation App',
          initialRoute: '/',
          routes: {
            '/': (context) => SplashScreen(),
            '/onboarding': (context) => OnBoarding(),
            '/homepage': (context) => HomePage(),
            '/selectDevice': (context) => const SelecionarDispositivoPage(),
                  },

        ));
  }
}
