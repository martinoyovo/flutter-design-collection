import 'package:flutter/material.dart';

class LightSwitch extends StatefulWidget {
  const LightSwitch({Key? key}) : super(key: key);

  @override
  State<LightSwitch> createState() => _LightSwitchState();
}

class _LightSwitchState extends State<LightSwitch> {
  double containerHeight = 0;
  double stickHeight = 360;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: LightClipper(size.height),
              child: AnimatedContainer(
                curve: Curves.bounceOut,
                duration: const Duration(milliseconds: 200),
                color: bgColor,
                height: containerHeight,
              ),
            ),
          ),
          Positioned(
            top: 355,
            right: 50,
            child: Container(
              padding: const EdgeInsets.all(5),
              height: 200,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(25)
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 55,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.bounceOut,
                  width: 4,
                  height: stickHeight,
                  color: Colors.white,
                ),
                GestureDetector(
                  onVerticalDragUpdate: (details) {
                    //print(details.delta.dy);
                    setState(() {
                      stickHeight += details.delta.dy;
                    });
                  },
                  onVerticalDragEnd: (details) {
                    //print('end');
                    if(stickHeight <= 400) {
                      setState(() {
                        containerHeight = 0;
                        stickHeight = 360;
                      });
                    }
                    else {
                      setState(() {
                        containerHeight = size.height;
                        stickHeight = 500;
                      });
                    }
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 29,
            right: 0,
            child: AppBar(
              elevation: 0,
              centerTitle: false,
              backgroundColor: Colors.transparent,
              leading: Icon(Icons.arrow_back, size: 35, color: containerHeight == 0 ? Colors.white : Colors.black,),
              title: Text('Study Room', style: TextStyle(fontSize: 33, color: containerHeight == 0 ? Colors.white : Colors.black, fontWeight: FontWeight.w600),),
            ),
          )
        ],
      ),
    );
  }
}

class LightClipper extends CustomClipper<Path> {
  final double screenHeight;
  LightClipper(this.screenHeight);

  @override
  Path getClip(Size size) {
    final height = size.height;
    final width = size.width;

    double control = height >= screenHeight*0.95 ? 0 : 40;

    final path = Path();

    path.lineTo(0, control);
    path.relativeQuadraticBezierTo(width/2, -control, width, 0);
    path.relativeLineTo(0, height - control);
    path.lineTo(0, height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

Color bgColor = const Color(0xFFFECE02);