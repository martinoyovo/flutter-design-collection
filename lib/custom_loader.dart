import 'package:flutter/material.dart';
import 'dart:math' as math;

List<Color> colorList = [
  Colors.yellow,
  Colors.greenAccent,
  Colors.green,
  Colors.blue,
  Colors.purple,
  Colors.pink,
  Colors.pinkAccent,
  Colors.orange,
];

class CustomLoader extends StatefulWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> with TickerProviderStateMixin {

  AnimationController? animationController;

  Animation? angleAnimation;

  Animation? radiusAnimation;

  Animation? sizeAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
      reverseDuration: const Duration(milliseconds: 1200),
    );
    angleAnimation = Tween<double>(begin: 0, end: math.pi)
      .animate(
        CurvedAnimation(
          parent: animationController!,
          curve: Curves.easeInOut
        )
      );

    radiusAnimation = Tween<double>(begin: 5, end: 50).animate(animationController!);

    sizeAnimation = Tween<double>(begin: 60, end: 25).animate(animationController!);

    animationController!.addListener(() {
      if(angleAnimation!.status == AnimationStatus.completed) {
        animationController!.reverse();
      }

      setState(() {});
    });

    animationController!.repeat(reverse: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: List.generate(colorList.length, (i) {
          final angle = 2*(i+1)*math.pi/8-angleAnimation!.value;

          return Positioned(
            top: 70*math.cos(angle),
            right: 70*math.sin(angle),
            child: Transform.translate(
              offset: Offset(-size.width/2.25, size.height/2.25),
              child: Transform.rotate(
                angle: angle,
                child: Container(
                  height: sizeAnimation!.value,
                  width: sizeAnimation!.value,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorList[i], width: sizeAnimation!.value/8),
                    borderRadius: BorderRadius.circular(radiusAnimation!.value as double)
                  ),
                ),
              ),
            ),
          );
      })),
    );
  }
}