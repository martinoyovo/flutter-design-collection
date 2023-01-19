import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';


class LogoHome extends StatefulWidget {
  const LogoHome({Key? key}) : super(key: key);

  @override
  State<LogoHome> createState() => _LogoHomeState();
}

class _LogoHomeState extends State<LogoHome> with TickerProviderStateMixin {
  AnimationController? topController;
  AnimationController? middleController;
  AnimationController? bottomController;
  AnimationController? fadeController;

  Animation<double>? topAnimation;
  Animation<double>? middleAnimation;
  Animation<double>? bottomAnimation;
  Animation<double>? fadeAnimation;

  @override
  void initState() {
    bottomController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    middleController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    topController = AnimationController(vsync: this, duration: const Duration(seconds: 7));
    fadeController = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    bottomAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(bottomController!);
    Timer(const Duration(seconds: 1), () {
      bottomController!.forward();
    });
    bottomController!.addListener(() {
      if (bottomAnimation!.value == 1) {
        middleController!.forward();
        middleAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(middleController!);
      }
      setState(() {});
    });

    middleController!.addListener(() {
      if (middleController!.value == 1) {
        topController!.forward();
        topAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(topController!);
      }
      setState(() {});
    });

    topController!.addListener(() {
      if (topController!.value == 1) {
        fadeController!.forward();
        fadeAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(fadeController!);
      }
      setState(() {});
    });

    fadeController!.addListener(() {
      setState(() {});
    });

    super.initState();

  }

  double _scaleFactor = 0.8;
  double originX = 3;
  double originY = 7;

  @override
  Widget build(BuildContext context) {

    return Material(
      color: Colors.black,
      child: GestureDetector(
        onScaleUpdate: (details) {
          setState(() {
            _scaleFactor = details.scale;
          });
        },
        onScaleEnd: (details){
          setState(() {
            _scaleFactor = _scaleFactor;
          });
        },
        child: Draggable(
          feedback: _logoContainer(),
          childWhenDragging: Container(),
          child: _logoContainer(),
          onDragEnd: (details) {
            setState(() {
              if(details.offset.dx < 0) {
                originX = 0;
              }

              if(details.offset.dy < 0) {
                originY = 0;
              }
              originX = details.offset.dx/15;
              originY = details.offset.dy/15;
            });
          },
        ),
      ),
    );
  }

  Widget _logoContainer() => Transform.scale(
    scale: _scaleFactor,
    child: CustomPaint(
      size: Size.infinite,
      painter: LogoPainter(
        bottomProgress: bottomAnimation!.value,
        middleProgress: middleAnimation?.value ?? 0,
        topProgress: topAnimation?.value ?? 0,
        fadeProgress: fadeAnimation?.value ?? 0,
        originX: originX,
        originY: originY
      ),
      child: Container(),
    ),
  );
}

class LogoPainter extends CustomPainter {
  final double? topProgress;
  final double? middleProgress;
  final double? bottomProgress;
  final double? fadeProgress;
  final double originX;
  final double originY;

  LogoPainter({this.topProgress, this.middleProgress, this.bottomProgress, this.fadeProgress, required this.originX, required this.originY});

  @override
  void paint(Canvas canvas, Size size) {

    const double unit = 40;

    final bottomPaint = Paint()
      ..strokeWidth = 4
      ..color = topProgress == 1.0 ? const Color(0xFF0C64A9).withOpacity(fadeProgress!) : Colors.white
      ..style = topProgress == 1.0 ? PaintingStyle.fill : PaintingStyle.stroke;

    final middlePaint = Paint()
      ..strokeWidth = 4
      ..color = topProgress == 1.0 ? const Color(0xFF62CFFC).withOpacity(fadeProgress!) : Colors.white
      ..style = topProgress == 1.0 ? PaintingStyle.fill : PaintingStyle.stroke;

    final topPaint = Paint()
      ..strokeWidth = 4
      ..color = topProgress == 1.0 ? const Color(0xFF62CFFC).withOpacity(fadeProgress!) : Colors.white
      ..style = topProgress == 1.0 ? PaintingStyle.fill : PaintingStyle.stroke;

    final bottom = Path();
    bottom.moveTo(unit*(2+originX), unit*(4+originY));
    bottom.relativeLineTo(unit*3, unit*3);
    bottom.relativeLineTo(-unit*2, 0);
    bottom.relativeLineTo(-unit*2, -unit*2);

    final middle = Path();
    middle.moveTo(unit*(1+originX), unit*(5+originY));
    middle.relativeLineTo(unit*2, -unit*2);
    middle.relativeLineTo(unit*2, 0);
    middle.relativeLineTo(-unit*3, unit*3);
    middle.close();


    final top = Path();
    top.moveTo(unit*(3+originX), unit*(0+originY));
    top.relativeLineTo(unit*2, 0);
    top.relativeLineTo(-unit*4.52, unit*4.52);
    top.relativeLineTo(-unit*1, -unit*1);
    top.close();

    animatePath(bottom, bottomPaint, canvas, bottomProgress!);
    animatePath(middle, middlePaint, canvas, middleProgress!);
    animatePath(top, topPaint, canvas, topProgress!);
  }

  //animate the drawn path
  animatePath(Path path, Paint paint, Canvas canvas, double progress) {
    PathMetrics shadowMetrics = path.computeMetrics();
    for (PathMetric pathMetric in shadowMetrics) {
      Path extractPath = pathMetric.extractPath(
        0.0,
        pathMetric.length * progress,
      );
      canvas.drawPath(extractPath, paint);
    }
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
