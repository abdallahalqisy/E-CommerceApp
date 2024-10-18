import 'dart:async';
import 'package:fashionapp/core/constants.dart';
import 'package:fashionapp/layout/layout_screen.dart';
import 'package:flutter/material.dart';

class InmationScreen extends StatefulWidget {
  const InmationScreen({super.key});

  @override
  State<InmationScreen> createState() => _InmationScreenState();
}

class _InmationScreenState extends State<InmationScreen>
    with SingleTickerProviderStateMixin {
  double ballY = 0;
  double widthVal = 50;
  double heightVal = 50;
  double bottomVal = 500;
  bool add = false;
  bool showShadow = false;
  int times = 0;
  bool showComic = false;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {
          if (add) {
            ballY += 15;
          } else {
            ballY -= 15;
          }
          if (ballY <= -200) {
            times += 1;
            add = true;
            showShadow = true;
          }
          if (ballY >= 0) {
            add = false;
            showShadow = false;
            widthVal += 50;
            heightVal += 50;
            bottomVal -= 200;
          }
          if (times == 3) {
            showShadow = false;
            widthVal = MediaQuery.of(context).size.width;
            heightVal = MediaQuery.of(context).size.height;
            Timer(const Duration(milliseconds: 300), () {
              setState(() {
                showComic = true;
              });
            });
            _controller.stop();
          }
        });
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedPositioned(
                bottom: bottomVal,
                duration: const Duration(milliseconds: 600),
                child: Column(
                  children: [
                    Transform.translate(
                      offset: Offset(0, ballY),
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 200),
                        scale: times == 3 ? 5 : 1,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          width: widthVal,
                          height: heightVal,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: mainColor,
                          ),
                        ),
                      ),
                    ),
                    if (showShadow)
                      Container(
                        width: 50,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.2),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                  ],
                ),
              ),
              if (showComic) Positioned(child: LayoutScreen()),
            ],
          ),
        ),
      ),
    );
  }
}
