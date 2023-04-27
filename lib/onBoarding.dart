// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:glassmorphism/glassmorphism.dart';
// import 'package:lottie/lottie.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           SizedBox(
//             width: double.infinity,
//             height: double.infinity,
//             child: Image.asset(
//               'assets/technology.jpg',
//               fit: BoxFit.cover,
//               scale: 1,
//             ),
//           ),
//           SafeArea(
//               child: Center(
//             child: Text('Home Remote',
//                 style: GoogleFonts.comfortaa(
//                     textStyle: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.white))),
//           )),
//           GlassmorphicContainer(
//               width: MediaQuery.of(context).size.width * 0.9,
//               height: 120,
//               borderRadius: 0,
//               linearGradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Color(0xFFF75035).withAlpha(55),
//                     Color(0xFFffffff).withAlpha(45),
//                   ],
//                   stops: [
//                     0.3,
//                     1,
//                   ]),
//               border: 0,
//               blur: 7,
//             borderGradient: LinearGradient(
//                 begin: Alignment.bottomRight,
//                 end: Alignment.topLeft,
//                 colors: [
//                   Color(0xFF4579C5).withAlpha(100),
//                   Color(0xFFFFFFF).withAlpha(55),
//                   Color(0xFFF75035).withAlpha(10),
//                 ],
//                 stops: [
//                   0.06,
//                   0.95,
//                   1
//                 ]),
//             child: Column(
//               children: [
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width*0.8,
//                   height: MediaQuery.of(context).size.height,
//                   child: Lottie.asset('assets/manualBluetooth.json',
//                   fit:BoxFit.contain),
//
//                 ),
//               ],
//             ),
//
//           )
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';


class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            // image: DecorationImage(
            //     image: Image.asset("assets/technology.jpg").image, fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: GlassmorphicContainer(
              width: MediaQuery.of(context).size.width ,
              height: MediaQuery.of(context).size.height ,
              borderRadius: 0,
              blur: 0,
              alignment: Alignment.bottomCenter,
              border: 0,
              linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFF75035).withAlpha(55),
                    Color(0xFFffffff).withAlpha(45),
                  ],
                  stops: [
                    0.3,
                    1,
                  ]),
              borderGradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    Color(0xFF4579C5).withAlpha(100),
                    Color(0xFFFFFFF).withAlpha(55),
                    Color(0xFFF75035).withAlpha(10),
                  ],
                  stops: [
                    0.06,
                    0.95,
                    1
                  ]),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        // Positioned(
                        //   bottom: MediaQuery.of(context).size.height * 0.3 - 70,
                        //   left: 40,
                        //   child: Container(
                        //     width: 100,
                        //     height: 100.0,
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       gradient: LinearGradient(colors: [
                        //         Color(0xFFBC1642),
                        //         Color(0xFFCB5AC6),
                        //       ]),
                        //     ),
                        //   ),
                        // ),
                        // Positioned(
                        //   bottom: 50,
                        //   left: 30,
                        //   child: Container(
                        //     width: 80,
                        //     height: 40,
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.rectangle,
                        //       gradient: LinearGradient(colors: [
                        //         Color(0xFFFDFC47),
                        //         Color(0xFF24FE41),
                        //       ]),
                        //     ),
                        //   ),
                        // ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // glassCard(context),
                            GlassmorphicContainer(
                              width:
                              MediaQuery.of(context).size.width * 0.9 - 20,
                              height:
                              MediaQuery.of(context).size.height * 0.4 - 20,
                              borderRadius: 35,
                              margin: EdgeInsets.all(10),
                              blur: 10,
                              alignment: Alignment.bottomCenter,
                              border: 2,
                              linearGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFFFFFF).withAlpha(0),
                                    Color(0xFFFFFFF).withAlpha(0),
                                  ],
                                  stops: [
                                    0.3,
                                    1,
                                  ]),
                              borderGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFFFFFF).withAlpha(01),
                                    Color(0xFFFFFFF).withAlpha(100),
                                    Color(0xFFFFFFF).withAlpha(01),
                                  ],
                                  stops: [
                                    0.2,
                                    0.9,
                                    1,
                                  ]),
                              child: Body2(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget glassCard(var context) {
  double textScaleFactor = MediaQuery.textScaleFactorOf(context);
  return GlassmorphicFlexContainer(
      flex: 2,
      borderRadius: 35,
      padding: EdgeInsets.all(25),
      blur: 14,
      alignment: Alignment.bottomCenter,
      border: 2,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF0FFFF).withOpacity(0.2),
          Color(0xFF0FFFF).withOpacity(0.2),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF0FFFF).withOpacity(1),
          Color(0xFFFFFFF),
          Color(0xFF0FFFF).withOpacity(1),
        ],
      ),
      child:  Column(
        children: [

        ],
      )
  );
}

class Body2 extends StatelessWidget {
  const Body2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Please turn on the Home \n Automation Device.',
              style: GoogleFonts.comfortaa(textStyle :TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),)
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white54, width: 0.5),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Lottie.asset('assets/manualBluetooth.json', fit: BoxFit.cover),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Next',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ClipOval(
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.white,
                  child: IconButton(
                    onPressed: (){

                      Navigator.pushReplacementNamed(context, '/homepage');
                    },
                    icon:Icon(Icons.arrow_forward),
                    color: Colors.black,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}









