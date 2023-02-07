import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BikeTraveller extends StatefulWidget {
  const BikeTraveller({Key? key}) : super(key: key);

  @override
  State<BikeTraveller> createState() => _BikeTravellerState();
}

class _BikeTravellerState extends State<BikeTraveller> with TickerProviderStateMixin {
  AnimationController? legOneController;
  AnimationController? legTwoController;
  AnimationController? wheelRotationController;
  AnimationController? wheelShakeController;
  AnimationController? manShakeController;

  Animation<double>? legOneAnimation;
  Animation<double>? legTwoAnimation;
  Animation<double>? wheelRotationAnimation;
  Animation<double>? wheelMoveAnimation;
  Animation<double>? manMoveAnimation;

  @override
  void initState() {
    legOneController = AnimationController(vsync: this, duration: const Duration(milliseconds: 280));
    legTwoController = AnimationController(vsync: this, duration: const Duration(milliseconds: 280));
    wheelRotationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400))..repeat();
    manShakeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 280))..repeat(reverse: true);
    wheelShakeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 280))..repeat(reverse: true);

    legOneAnimation = Tween<double>(begin: 0.0, end: 20.0).animate(legOneController!);
    legTwoAnimation = Tween<double>(begin: 0.0, end: 20.0).animate(legTwoController!);
    wheelRotationAnimation = Tween<double>(begin: 0.0, end: math.pi*2).animate(wheelRotationController!);
    manMoveAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(manShakeController!);
    wheelMoveAnimation = Tween<double>(begin: 0.0, end: 5.0).animate(wheelShakeController!);


    legOneController!.forward();

    legOneController!.addListener(() {
      if (legOneAnimation!.status == AnimationStatus.completed) {
        legOneController!.reverse();
      }
      if (legOneAnimation!.status == AnimationStatus.completed) {

      }
      setState(() {});
    });

    legTwoController!.forward();
    legTwoController!.addListener(() {
      if (legTwoAnimation!.status == AnimationStatus.completed) {
        legTwoController!.reverse();

      }
      setState(() {});
    });

    legOneController!.repeat(reverse: true);
    legTwoController!.repeat(reverse: true);
    //wheelController!.repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        children: [
          Transform.rotate(
            angle: -math.pi/5.3,
            child: Transform.translate(
              offset: const Offset(-40, -90),
              child: Stack(
                children: [
                  Transform.scale(
                    scale: 0.75,
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: Size.infinite,
                          painter: StickyManPainter(
                            legOneSpeed: legOneAnimation!.value,
                            legTwoSpeed: legTwoAnimation?.value ?? 0,
                            manMoveSpeed: manMoveAnimation?.value ?? 0
                          ),
                          child: Container(),
                        ),
                        CustomPaint(
                          size: Size.infinite,
                          painter: WheelOnePainter(
                            speed: wheelRotationAnimation!.value,
                            wheelMove: wheelMoveAnimation?.value ?? 0
                          ),
                          child: Container(),
                        ),
                        CustomPaint(
                          size: Size.infinite,
                          painter: WheelTwoPainter(
                            speed: wheelRotationAnimation!.value,
                            wheelShake: wheelMoveAnimation?.value ?? 0
                          ),
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                  CustomPaint(
                    size: Size.infinite,
                    painter: RoadPainter(),
                    child: Container(),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height*0.6,
                    right: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("100", style: TextStyle(color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.bold, fontSize: 35),),
                        const SizedBox(height: 2,),
                        const Text("METERS", style: TextStyle(color: Colors.white, fontSize: 15),),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const Positioned(
            top: 170,
            left: 20,
            right: 20,
            child: Center(child: Text('TRAVEL', style: TextStyle(fontSize: 62, fontFamily: 'Essence', color: Colors.white70),)),
          ),
          Positioned(
            bottom: 45,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  cursorColor: Colors.white70,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    prefixIcon: const Icon(CupertinoIcons.person, color: Colors.white70,)
                  ),

                ),
                const SizedBox(height: 15,),
                TextField(
                  cursorColor: Colors.white70,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    prefixIcon: const Icon(CupertinoIcons.lock, color: Colors.white70,)
                  ),
                ),
                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const InkWell(
                      child: Text('LOGIN', style: TextStyle(color: Colors.white70, fontSize: 16),),
                    ),
                    const SizedBox(width: 8,),
                    Container(
                      width: 1,
                      height: 14,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 8,),
                    const InkWell(
                      child: Text('SIGNUP', style: TextStyle(color: Colors.white70, fontSize: 16),),
                    ),
                  ],
                )

              ],
            )
          )
        ],
      ),
    );
  }
}

class StickyManPainter extends CustomPainter {
  final double? legOneSpeed;
  final double? legTwoSpeed;
  final double? manMoveSpeed;

  StickyManPainter({this.legOneSpeed, this.legTwoSpeed, this.manMoveSpeed});

  @override
  void paint(Canvas canvas, Size size) {
    final double originX = size.width/2.5+manMoveSpeed!;
    final double originY = size.height/1.94+manMoveSpeed!;
    const double unit = 50;

    stickerManPainter(double strokeWidth) => Paint()
      ..strokeWidth = strokeWidth
      ..color = const Color(0xFF6C6E6C)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    //canvas.drawPaint(backPaint);
    //1
    canvas.drawLine(Offset(originX-unit-20, originY), Offset(originX+unit-20, originY), stickerManPainter(45));

    //2
    canvas.drawLine(Offset(originX+unit-8, originY), Offset(originX+unit-8, originY+unit+10), stickerManPainter(20));

    //3
    canvas.drawLine(Offset(originX+unit-8, originY+unit+10), Offset(originX+unit+40, originY+unit+10), stickerManPainter(20));

    //4
    final joinPoint1 = Offset(originX-unit+legOneSpeed!*2, originY+80-legOneSpeed!*2);
    canvas.drawLine(Offset(originX-unit-25, originY), joinPoint1, stickerManPainter(22));
    canvas.drawLine(joinPoint1, Offset(originX-unit-20+legOneSpeed!*2, originY+135-legOneSpeed!*2), stickerManPainter(22));

    //5
    final joinPoint2 = Offset(originX-unit+55-legTwoSpeed!*2, originY+50+legTwoSpeed!*2-5);
    canvas.drawLine(Offset(originX-unit-20, originY), joinPoint2, stickerManPainter(22));
    canvas.drawLine(joinPoint2, Offset(originX-unit+30-legTwoSpeed!*2, originY+110+legTwoSpeed!*2), stickerManPainter(22));

    //head
    canvas.drawCircle(Offset(originX+unit+33, originY - 22), 22, stickerManPainter(20));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}

Paint wheelPainter({double? strokeWidth, StrokeCap? strokeCap, PaintingStyle? style}) => Paint()
  ..strokeWidth = strokeWidth ?? 10
  ..color = const Color(0xFF13FFB6)
  ..strokeCap = strokeCap ?? StrokeCap.butt
  ..style = style ?? PaintingStyle.stroke;

const double unit = 50;


class WheelOnePainter extends CustomPainter { 
  final double? speed;
  final double? wheelMove;

  WheelOnePainter({this.speed, this.wheelMove});

  @override
  void paint(Canvas canvas, Size size) {

    final double originX = size.width/2.4;
    final double originY = size.height/2+wheelMove!;

    //smallest wheel on the left
    final wheelCenterX = originX-unit-35;
    final wheelCenterY = originY+158;
    final wheelCenter = Offset(wheelCenterX, wheelCenterY);

    canvas.drawCircle(wheelCenter, 11, wheelPainter(style: PaintingStyle.fill));

    //wheel border
    canvas.drawCircle(wheelCenter, 65, wheelPainter());

    //lines
    canvas.drawLine(wheelCenter, Offset(wheelCenterX+65*math.cos(speed!), wheelCenterY+65*math.sin(speed!)), wheelPainter());

    canvas.drawLine(wheelCenter, Offset(wheelCenterX-60*math.sin(speed!), wheelCenterY+70*math.cos(speed!)), wheelPainter());

    canvas.drawLine(wheelCenter, Offset(wheelCenterX+70*math.sin(speed!), wheelCenterY-55*math.cos(speed!)), wheelPainter());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}

class WheelTwoPainter extends CustomPainter {
  final double? speed;
  final double? wheelShake;

  WheelTwoPainter({this.speed, this.wheelShake});

  @override
  void paint(Canvas canvas, Size size) {
    final double originX = size.width/1.3;
    final double originY = size.height/2+wheelShake!;

    //smallest wheel on the left
    final wheelCenterX = originX-unit-35;
    final wheelCenterY = originY+158;
    final wheelCenter = Offset(wheelCenterX, wheelCenterY);

    canvas.drawCircle(wheelCenter, 11, wheelPainter(style: PaintingStyle.fill));

    //wheel border
    canvas.drawCircle(wheelCenter, 65, wheelPainter());

    //lines
    canvas.drawLine(wheelCenter, Offset(wheelCenterX+65*math.cos(speed!), wheelCenterY+65*math.sin(speed!)), wheelPainter());

    canvas.drawLine(wheelCenter, Offset(wheelCenterX-60*math.sin(speed!), wheelCenterY+70*math.cos(speed!)), wheelPainter());

    canvas.drawLine(wheelCenter, Offset(wheelCenterX+70*math.sin(speed!), wheelCenterY-55*math.cos(speed!)), wheelPainter());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}

class RoadPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    canvas.drawLine(Offset(-200, size.height*0.7), Offset(size.width*1.5, size.height*0.71), wheelPainter(strokeWidth: 6));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}
