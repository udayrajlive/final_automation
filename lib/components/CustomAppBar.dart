import 'dart:ui';
import 'package:final_automation/HomePage.dart';
import 'package:final_automation/provider/StatusConexaoProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? Title;
  final bool? isBluetooth;
  final bool? isDiscovering;
  final Function? onPress;

  const CustomAppBar({
    Key? key,
    @required this.Title,
    this.isBluetooth,
    this.isDiscovering,
    this.onPress,
  }) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    DisconnectarBluetooth() {
      Provider.of<StatusConexaoProvider>(context, listen: false)
          .setDevice(null);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        toolbarHeight: 80,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: new Center(
            child: Row(
              children: [
                new Text(Title!, textAlign: TextAlign.center),
              ],
            )),
        backgroundColor: Colors.blueAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              height: 60,
              width: 60,
              child: Consumer<StatusConexaoProvider>(
                  builder: (context, StatusConnectionProvider, widget) {
                    return (isBluetooth!
                        ? ElevatedButton(
                      onPressed: StatusConnectionProvider.device != null
                          ? () {

                        Provider.of<StatusConexaoProvider>(context,
                            listen: false)
                            .setDevice(null);
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                settings: const RouteSettings(name: '/homepage'),
                                builder: (context) =>
                                const HomePage())); // push it back in

                      }
                          : onPress!(),
                      child: Icon(StatusConnectionProvider.device != null
                          ? Icons.bluetooth_connected
                          : Icons.bluetooth_disabled),
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          primary: StatusConnectionProvider.device  != null
                              ?   Color.fromRGBO(15, 171, 118, 1)
                              : Colors.black),
                    )
                        : SizedBox.shrink());
                  }),
            ),
          )

        ],
      ),
    );
  }
}
