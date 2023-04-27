import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:lottie/lottie.dart';


class ButtonDoubleComponent extends StatefulWidget {
  final String? buttonName;
  final String? comandOn;
  final String? comandOff;
  final BluetoothConnection? connection;
  final int clientID;
  const ButtonDoubleComponent(
      {Key? key,
      this.buttonName,
      this.comandOn,
      this.comandOff,
      this.connection,
      required this.clientID})
      : super(key: key);
  _ButtonState createState() => _ButtonState();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ButtonState extends State<ButtonDoubleComponent> {
  bool buttonClicado = false;
  final TextEditingController textEditingController = TextEditingController();
  List<_Message> messages = <_Message>[];

  _changeButtonColor() {
    setState(() {
      buttonClicado = !buttonClicado;
    });
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LiteRollingSwitch(
            onTap: () {
              _sendMessage(
                  buttonClicado ? widget.comandOn! : widget.comandOff!);
              _changeButtonColor();
            },
            onSwipe: () {
              _sendMessage(
                  buttonClicado ? widget.comandOn! : widget.comandOff!);
              _changeButtonColor();
            },
            onDoubleTap: () {},
            onChanged: (bool value) {
  if(value ){
    print("print $buttonClicado button");
  }
  else{
    print("print $value value $buttonClicado");
  }
            },
            animationDuration: Duration(milliseconds: 300),
            value: buttonClicado,
            textOn: "on",
            textOff: "off",
            colorOn: Colors.greenAccent,
            colorOff: Colors.redAccent,
            iconOn: Icons.done,
            iconOff: Icons.flash_off_rounded,
            textSize: 18.0,
          ),
          SizedBox(
            width: 12,
          ),
          Container(
            width: 80,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),

            child: Center(
              child: Text(
                widget.buttonName!,
                style: TextStyle(
                  shadows:  [
                    BoxShadow(
                      blurRadius: 4,
                      color:  buttonClicado ? Colors.teal:Colors.black26,

                    ),

                  ],
                  fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color:
                        buttonClicado ? Colors.greenAccent : Colors.redAccent),
              ),
            ),
          ),
          Visibility(
            visible: buttonClicado,
            child: SizedBox(
              width: 60,
              height: 60,
              child: Lottie.asset("assets/Light.json",
              fit: BoxFit.contain,
                repeat: false,

              )
            ),
          ),
        ],
      ),
    );
  }

  _sendMessage(text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.length > 0) {
      try {
        widget.connection!.output
            .add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await widget.connection!.output.allSent;

        setState(() {
          messages.add(_Message(widget.clientID, text));
        });
      } catch (e) {
        setState(() {});
      }
    }
  }
}
// Container(
// height: 60,
// width: 90,
// child: TextButton(
// onPressed: (){
//
// _sendMessage(buttonClicado ? widget.comandOn! : widget.comandOff!);
// _changeButtonColor();
//
// },
// child: Text(
// widget.buttonName!,
// style: TextStyle(color: Colors.white),
// ),
// style: TextButton.styleFrom( backgroundColor: buttonClicado
// ? Color.fromRGBO(237, 46, 39, 1)
// : Color.fromRGBO(0, 0, 0, 1),
// shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),),
// )));
