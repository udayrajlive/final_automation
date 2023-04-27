// ignore_for_file: file_names

import 'package:final_automation/ControlePrincipal.dart';
import 'package:final_automation/SelecionarDispositivo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'components/CustomAppBar.dart';
import 'provider/StatusConexaoProvider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onPressBluetooth() {
      return (() async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            settings: const RouteSettings(name: 'selectDevice'),
            builder: (context) => const SelecionarDispositivoPage()));
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        Title: 'Remote',
        isBluetooth: true,
        isDiscovering: false,
        onPress: onPressBluetooth,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
          child: Consumer<StatusConexaoProvider>(
              builder: (context, StatusConnectionProvider, widget) {
            return (StatusConnectionProvider.device == null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width*0.7,
                    height: 200,
                    child: Lottie.asset("assets/blueSearch.json",fit: BoxFit.contain),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const Icon(Icons.bluetooth_searching, size: 50),
                          const Text(
                            "Search for Bluetooth devices",
                            style: TextStyle(
                              color:  Colors.black,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                  ],
                )
                : ControlePrincipalPage(
                    server: StatusConnectionProvider.device));
          }),
        ),
      ),
    );
  }
}
