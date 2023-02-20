import 'package:flutter/material.dart';
import 'package:flutter_logo_animation/utils/stats.dart';
import 'package:flutter_logo_animation/utils/utils.dart';

class BankCardAnimation extends StatefulWidget {
  const BankCardAnimation({Key? key}) : super(key: key);

  @override
  State<BankCardAnimation> createState() => _BankCardAnimationState();
}

class _BankCardAnimationState extends State<BankCardAnimation> with TickerProviderStateMixin {

  Animation? heightAnimation;
  Animation? marginAnimation;
  Animation? colorAnimation;

  AnimationController? animationController;

  int activeTabIndex = 0;
  List<Map<String, dynamic>> activeTabData = statsList.first['data'];

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    heightAnimation = Tween<double>(begin: 0.28, end: 1).animate(animationController!);
    marginAnimation = Tween<double>(begin: 20, end: 0).animate(animationController!);
    colorAnimation = ColorTween(begin: Utils.colorPurple, end: Utils.colorBlue).animate(animationController!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          //animationController!.forward();
          if(heightAnimation!.status == AnimationStatus.completed) {
            animationController!.reverse();
          }
          else {
            animationController!.forward();
          }
        },
        child: AnimatedBuilder(
            animation: heightAnimation!,
            builder: (context, _) {
              return Stack(
                children: [
                  Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.ease,
                      margin: EdgeInsets.symmetric(horizontal: marginAnimation!.value),
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: heightAnimation!.value*80),
                      height: size.height*heightAnimation!.value,
                      width: size.width,
                      decoration: BoxDecoration(
                          gradient: RadialGradient(
                              radius: 0.8,
                              colors: [
                                Utils.colorPink,
                                colorAnimation!.value
                              ]
                          ),
                          borderRadius: BorderRadius.circular(marginAnimation!.value)
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("PREMIUM", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                              Text("DREAM BANK", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              const SizedBox(width: 10,),
                              Image.asset('assets/chip.png', scale: 5,),
                              const SizedBox(width: 20,),
                              const Text('1150 2280 3319 6623', style: TextStyle(color: Colors.white, fontSize: 18),)
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Text('FLUTTEREASE', style: TextStyle(fontSize: 22, color: Colors.white),),
                              const Spacer(),
                              Image.asset('assets/mastercard.png', height: 50, width: 55,)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  if (heightAnimation!.value >= 0.8) ...[
                    Positioned(
                      top: size.height*0.4,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: activeTabData.map((valueList) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    width: 26,
                                    height: double.parse(valueList['value'].toString())*6,
                                    margin: const EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(color: Colors.white, width: 2.5)
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Text('${valueList['value']}\$',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: size.height*0.25,
                      left: 20,
                      right: 20,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('WEEKLY STATUS', style: TextStyle(fontSize: 30, color: Colors.white),),
                            ],
                          ),
                          const SizedBox(height: 14,),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 35),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 2
                                  )
                                ],
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: statsList.map((s) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      activeTabIndex = statsList.indexOf(s);
                                      activeTabData = s['data'];
                                    });
                                    debugPrint(statsList.indexOf(s).toString());
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: (activeTabIndex == statsList.indexOf(s)) ? Colors.white : Colors.transparent,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text(s["tab"].toString().toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: (activeTabIndex == statsList.indexOf(s)) ? Utils.colorPink : Colors.white
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: size.height*0.18,
                      left: 20,
                      right: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('TOTAL : 425\$', style: TextStyle(color: Colors.white, fontSize: 35),)
                        ],
                      ),
                    ),
                  ] else const SizedBox()
                ],
              );
            }
        ),
      ),
    );
  }
}
