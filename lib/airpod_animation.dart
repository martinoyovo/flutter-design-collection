import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AirpodAnimation extends StatefulWidget {
  const AirpodAnimation({Key? key}) : super(key: key);

  @override
  _AirpodAnimationState createState() => _AirpodAnimationState();
}

class _AirpodAnimationState extends State<AirpodAnimation> {
  double angle = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/bg.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
              child: Container(
                color: Colors.grey.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40)
                ),
                color: Colors.white
              ),
              child: Column(
                children: [
                  const Text("Tino's Airpods Max",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //0 0 0 0
                  //0 1 0 0
                  //0 0 1 0
                  //0 0 0 1

                  Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.004)
                      ..rotateY(angle),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          angle = angle + details.delta.dx / 100;
                        });
                      },
                      child: Image.asset("assets/airpods.png", height: 250,)
                    )
                  ),

                  const SizedBox(height: 20,),

                  const Icon(CupertinoIcons.battery_75_percent, color: Colors.green, size:  35,),

                  const SizedBox(height: 5,),

                  const Text('75 %', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}