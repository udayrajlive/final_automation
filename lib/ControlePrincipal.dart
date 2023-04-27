// ignore_for_file: file_names

import 'dart:io';
import 'dart:typed_data';
import 'package:final_automation/components/ButtonDouble.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


// import 'components/VoiceButtonPage.dart';

class ControlePrincipalPage extends StatefulWidget {
  final BluetoothDevice? server;
  const ControlePrincipalPage({this.server});

  @override
  _ControlePrincipalPage createState() => _ControlePrincipalPage();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ControlePrincipalPage extends State<ControlePrincipalPage> {
  static const clientID = 0;
  BluetoothConnection? connection;
  String? language;

  // ignore: deprecated_member_use
  List<_Message> messages = <_Message>[];
  String _messageBuffer = '';

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  bool isConnecting = true;
  bool get isConnected => connection != null && connection!.isConnected;

  bool isDisconnecting = false;
  bool buttonClicado = false;


  // List<String> _languages = ['en_US', 'es_ES', 'pt_BR'];


  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server!.address).then((_connection) {
      print('Connected to device');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.lightGreen,
            elevation: 0,
            duration: Duration(seconds: 3),
            content: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.lightGreen
                ),
                child: Column(
                  mainAxisAlignment:  MainAxisAlignment.center,
                  children: [
                    Text('Hurray!',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),),
                    Text('Paired Successfully',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),),
                  ],
                )),
          )
      );
      connection = _connection;

      setState
        (()
      {

        isConnecting = false;
        isDisconnecting = false;

      }
      );

      connection!.input!.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnected localy!');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.blueAccent,
                elevation: 0,
                duration: Duration(seconds: 3),
                content: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent
                    ),
                    child: Column(
                      mainAxisAlignment:  MainAxisAlignment.center,
                      children: [

                        Text('Disconnected localy!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),),
                      ],
                    )),
              )
          );
        } else {

          print('Disconnected remote!');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.blueAccent,
                elevation: 0,
                duration: Duration(seconds: 3),
                content: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent
                    ),
                    child: Column(
                      mainAxisAlignment:  MainAxisAlignment.center,
                      children: [
                        Text('Disconnected remote!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),),
                      ],
                    )),
              )
          );
        }
        if (mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      Future.delayed(Duration(seconds:3),(){
        Navigator.pushReplacementNamed(context, '/selectDevice');
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blueAccent,
            elevation: 0,
            duration: Duration(seconds: 2),
            content: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12))
              ),
              child: Row(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: [
                 Column(
                   children: [
                     Text('Oh Snap!',
                       style: TextStyle(
                         fontWeight: FontWeight.w600,
                         fontSize: 18,
                         color: Colors.white,
                       ),),
                     Text('Failed to connect, something is wrong!',
                       style: TextStyle(
                         fontSize: 14,
                         color: Colors.white,
                       ),),
                   ],
                 ),
                  Column(
                    children: [
                      IconButton(onPressed: (){
                        Future.delayed(Duration(milliseconds:200),(){
                          Navigator.pushReplacementNamed(context, '/selectDevice');
                        });
                      }, icon: Icon(Icons.refresh)),
                    ],
                  )
                ],
              )),
          ),
      );

      print('Failed to connect, something is wrong!');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected)
    {

      isDisconnecting = true;
      connection!.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    messages.map((_message) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
                (text) {
                  return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                }(_message.text.trim()),
                style: const TextStyle(color: Colors.white)),
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            width: 222.0,
            decoration: BoxDecoration(
                color:
                    _message.whom == clientID ? Colors.blueAccent : Colors.grey,
                borderRadius: BorderRadius.circular(7.0)),
          ),
        ],
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
      );
    }).toList();

    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: isConnected ? Expanded(
            flex:  2,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [

                  ]),
                  Column(children: [
                    ButtonDoubleComponent(
                      buttonName: "Switch 1",
                      comandOn: '2',
                      comandOff: '1',
                      clientID: clientID,
                      connection: connection,
                    ),
                  ]),

                  Column(children: [
                    ButtonDoubleComponent(
                      buttonName: "Switch 2",
                      comandOn: '4',
                      comandOff: '3',
                      clientID: clientID,
                      connection: connection,
                    ),
                  ]),

                  Column(children: [
                    ButtonDoubleComponent(
                      buttonName: "Switch 4",
                      comandOn: '6',
                      comandOff: '5',
                      clientID: clientID,
                      connection: connection,
                    ),
                  ]),

        Column(children: [
            ButtonDoubleComponent(
              buttonName: "Switch 5",
              comandOn: '8',
              comandOff: '7',
              clientID: clientID,
              connection: connection,
            ),
        ]),

        Column(children: [
            ButtonDoubleComponent(
              buttonName: "Switch 6",
              comandOn: '10',
              comandOff: '9',
              clientID: clientID,
              connection: connection,
            ),
        ])
                  ,
            ],
        ),
          ): Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Lottie.asset('assets/connecting_BP.json',fit: BoxFit.cover),

                ),
                Text("Paring...",
                style: GoogleFonts.comfortaa(textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color:  Colors.lightGreen
                )),)
              ],
            ),
          ),
      ),
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    for (var byte in data) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    }
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }
}
