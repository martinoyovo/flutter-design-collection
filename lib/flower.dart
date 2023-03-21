import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlowerAnimation extends StatefulWidget {
  const FlowerAnimation({Key? key}) : super(key: key);

  @override
  State<FlowerAnimation> createState() => _FlowerAnimationState();
}

class _FlowerAnimationState extends State<FlowerAnimation> with TickerProviderStateMixin {
  static const modulo = -math.pi/2;

  final angle1 = math.pi + modulo;
  final angle2 = 5*math.pi/4 + modulo;
  //the center
  final angle3 = 3*math.pi/2 + modulo;
  final angle4 = 7*math.pi/4 + modulo;
  final angle5 = 2*math.pi + modulo;

  AnimationController? animationController;
  Animation? angle1Animation;
  Animation? angle2Animation;
  Animation? angle4Animation;
  Animation? angle5Animation;

  Animation? color1Animation;
  Animation? color2Animation;

  Animation? tTLDotAnimation;

  String breatheText = '';
  Color textColor = color4;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
        reverseDuration: const Duration(seconds: 5)
    );
    angle1Animation = Tween<double>(begin: angle3, end: angle1).animate(
        CurvedAnimation(
            parent: animationController!,
            curve: Curves.ease
        )
    );

    angle2Animation = Tween<double>(begin: angle3, end: angle2).animate(
        CurvedAnimation(
            parent: animationController!,
            curve: Curves.ease
        )
    );

    angle4Animation = Tween<double>(begin: angle3, end: angle4).animate(
        CurvedAnimation(
            parent: animationController!,
            curve: Curves.ease
        )
    );

    angle5Animation = Tween<double>(begin: angle3, end: angle5).animate(
        CurvedAnimation(
            parent: animationController!,
            curve: Curves.ease
        )
    );

    tTLDotAnimation = Tween<double>(begin: 0, end: math.pi/2).animate(
        CurvedAnimation(
            parent: animationController!,
            curve: Curves.ease
        )
    );

    animationController!.addListener(() {
      if(animationController!.status == AnimationStatus.forward) {
        setState(() {
          breatheText = 'Breathe Out';
          textColor = color4;
        });
      }
      if(animationController!.status == AnimationStatus.reverse) {
        setState(() {
          breatheText = 'Breathe In';
          textColor = color2;
        });
      }
      setState(() {});
    });

    color1Animation = ColorTween(begin: color1, end: color3).animate(
        CurvedAnimation(
            parent: animationController!,
            curve: Curves.ease
        )
    );

    color2Animation = ColorTween(begin: color2, end: color4).animate(
        CurvedAnimation(
            parent: animationController!,
            curve: Curves.ease
        )
    );

    animationController!.repeat(reverse: true, max: 0.6);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Petal(angle: angle1Animation!.value, color1: color1Animation!.value, color2: color2Animation!.value),
          Petal(angle: angle2Animation!.value, color1: color1Animation!.value, color2: color2Animation!.value),
          Petal(angle: angle3, color1: color1Animation!.value, color2: color2Animation!.value),
          Petal(angle: angle4Animation!.value, color1: color1Animation!.value, color2: color2Animation!.value),
          Petal(angle: angle5Animation!.value, color1: color1Animation!.value, color2: color2Animation!.value),

          Positioned(
            top: -160,
            right: 0,
            left: 0,
            bottom: 0,
            child: Center(
              child: Stack(
                children: [
                  ...List.generate(8, (i) {
                    return Transform.rotate(
                      angle: i*tTLDotAnimation!.value/8-math.pi/1.95,
                      child: Transform.translate(
                        offset: const Offset(130, 0),
                        child: Container(
                          height: tTLDotAnimation!.value*14,
                          width: 4,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
                  ...List.generate(8, (i) {
                    return Transform.rotate(
                      angle: -i*tTLDotAnimation!.value/8-math.pi/2,
                      child: Transform.translate(
                        offset: const Offset(130, 0),
                        child: Container(
                          height: tTLDotAnimation!.value*14,
                          width: 4,
                          color: Colors.white,
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
          Positioned(
              top: 120,
              left: 0,
              right: 0,
              child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedSwitcher(
                      duration: animationController!.duration!,
                      switchInCurve: Curves.fastOutSlowIn,
                      child: Text(
                        key: ValueKey(breatheText),
                        breatheText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 50*animationController!.value,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                  )
              )
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    shape: const StadiumBorder()
                ),
                child: const Text('End',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Petal extends StatelessWidget {
  final double angle;
  final Color? color1;
  final Color? color2;
  const Petal({Key? key, required this.angle, this.color1, this.color2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: 50*math.cos(angle),
      right: 50*math.sin(angle),
      child: Transform.translate(
        offset: Offset(-size.width/2.5, size.height/2.5),
        child: Transform.rotate(
          angle: angle,
          child: ClipPath(
            clipper: PetalClipper(),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    color1!,
                    color2!
                  ]
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class PetalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final centerX = size.width/2;
    final centerY = size.height/2;

    double controlX = 50;
    double controlY = 50;
    Path path = Path();
    path.moveTo(centerX, centerY-controlY);
    path.relativeQuadraticBezierTo(controlX, controlY, 0, controlY*2);
    path.relativeQuadraticBezierTo(-controlX, -controlY, 0, -controlY*2);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}


const bgColor = Color(0xFF531A93);

const color1 = Color(0xFF35C4E4);
const color2 = Color(0xFF57ECAF);

const color3 = Color(0xFFEE2081);
const color4 = Colors.orange;
