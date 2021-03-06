import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> flapsAnimation;
  AnimationController flapsController;

  initState() {
    super.initState();

    catController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    
    catAnimation = Tween(begin: -50.0, end: -80.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      )
    );

    flapsController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    
    flapsAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(
        parent: flapsController,
        curve: Curves.linear,
      )
    );

    flapsAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        flapsController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        flapsController.forward();
      }
    });

    flapsController.forward();
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
      flapsController.forward();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
      flapsController.stop();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation!'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

   Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        // use Positioned so as to avoid enlarging the parent Stack
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
      // The cache element
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    // Positioned for making the flap "stick closer" to our box
    return Positioned(
      left: 5.0,
      top: 2.0,
      child: AnimatedBuilder(
        animation: flapsAnimation,
        // The cache element
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            angle: flapsAnimation.value,
            alignment: Alignment.topLeft,
          );
        },
      ),
    );
  }

  Widget buildRightFlap() {
    // Positioned for making the flap "stick closer" to our box
    return Positioned(
      right: 5.0,
      top: 2.0,
      child: AnimatedBuilder(
        animation: flapsAnimation,
        // The cache element
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        builder: (context, child) { 
          return Transform.rotate(
            child: child,
            angle: -flapsAnimation.value,
            alignment: Alignment.topRight,
          );
        },
      ),
    );
  }
}