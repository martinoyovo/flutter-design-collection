import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';


class LogoHome extends StatefulWidget {
  const LogoHome({Key? key}) : super(key: key);

  @override
  State<LogoHome> createState() => _LogoHomeState();
}

class _LogoHomeState extends State<LogoHome> with TickerProviderStateMixin {
  //animation controllers
  AnimationController? topController;
  AnimationController? middleController;
  AnimationController? bottomController;
  AnimationController? logoController;

  Animation<double>? topAnimation;
  Animation<double>? middleAnimation;
  Animation<double>? bottomAnimation;
  Animation<double>? logoAnimation;

  @override
  void initState() {
    logoController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    bottomController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    middleController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    topController = AnimationController(vsync: this, duration: const Duration(seconds: 4));

    logoAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(logoController!);
    bottomAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(bottomController!);

    Timer(const Duration(seconds: 1), () {
      logoController!.forward();
      bottomController!.forward();
    });

    logoController!.addListener(() {
      if (logoAnimation!.value == 1) {
        middleController!.forward();
        middleAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(middleController!);
      }
      setState(() {});
    });

    bottomController!.forward();

    bottomController!.addListener(() {
      setState(() {});
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

    /*topController!.addListener(() {
      if (middleAnimation!.value == 1) {
        topController!.forward();
        topAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(topAnimation!);
      }
      setState(() {});
    });*/


    super.initState();
  }

  @override
  void dispose() {
    bottomController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: CustomPaint(
        painter: LogoPainter(
          logoProgress:logoAnimation!.value,
          bottomProgress: bottomAnimation?.value ?? 0,
          middleProgress: middleAnimation?.value ?? 0,
          topProgress: topAnimation?.value ?? 0,
        ),
        child: Container(),
      ),
    );
  }
}


class LogoPainter extends CustomPainter {
  final double? logoProgress;
  final double? topProgress;
  final double? middleProgress;
  final double? bottomProgress;

  LogoPainter({this.topProgress, this.middleProgress, this.bottomProgress, this.logoProgress});

  @override
  void paint(Canvas canvas, Size size) {
    print(bottomProgress);

    const double unit = 50;
    const double originX = 2;
    const double originY = 6;

    final paint = Paint()
      ..strokeWidth = 4
      ..color = Colors.white
      ..style = PaintingStyle.stroke;

    final bottom = Path();
    bottom.moveTo(unit*(2+originX), unit*(4+originY));
    bottom.relativeLineTo(unit*3, unit*3);
    bottom.relativeLineTo(-unit*2, 0);
    bottom.relativeLineTo(-unit*2, -unit*2);
    bottom.close();

    animatePath(bottom, paint, canvas, bottomProgress!);

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

    canvas.drawPath(top, paint);
    canvas.drawPath(middle, paint);
    canvas.drawPath(bottom, paint);

    //animatePath(bottom, paint, canvas, bottomProgress!);

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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
