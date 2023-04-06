import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logo_animation/light_switch.dart';

class RedirectAnimation extends StatefulWidget {
  const RedirectAnimation({Key? key}) : super(key: key);

  @override
  State<RedirectAnimation> createState() => _RedirectAnimationState();
}

class _RedirectAnimationState extends State<RedirectAnimation> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          OpenContainer(
            openBuilder: (BuildContext context, VoidCallback _) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.4,
                ),
              );
            },
            openColor: Colors.red,
            //openColor: theme.cardColor,
            closedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(200)),
            ),
            closedElevation: 0,
            closedBuilder: (context, openContainer) {
              return Container(
                padding: const EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                  ),
                  onPressed: () {
                    openContainer();
                  },
                  child: const Text('7.99', style: TextStyle(color: Colors.black, fontSize: 17),),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

//Sample widget that uses [showModal] with [FadeScaleTransitionConfiguration].
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModal(
              context: context,
              configuration: const FadeScaleTransitionConfiguration(),
              builder: (BuildContext context) {
                return const _CenteredFlutterLogo();
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

//Displays a centered Flutter logo with size constraints.
class _CenteredFlutterLogo extends StatelessWidget {
  const _CenteredFlutterLogo();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 250,
        height: 250,
        child: Material(
          child: Center(
            child: FlutterLogo(size: 250),
          ),
        ),
      ),
    );
  }
}