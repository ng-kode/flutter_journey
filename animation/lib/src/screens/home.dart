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
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    
    catAnimation = Tween(begin: -50.0, end: -80.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      )
    );

    flapsController = AnimationController(
      duration: Duration(seconds: 2),
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
        flapsController.repeat();
      }
    });

    flapsController.forward();
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
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
      child: AnimatedBuilder(
        animation: flapsAnimation,
        // The cache element
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.red,
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
}