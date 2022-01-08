import 'dart:math';

import 'package:flutter/material.dart';

class PageTwoScreen extends StatefulWidget {
  const PageTwoScreen({Key? key}) : super(key: key);

  @override
  _PageTwoScreenState createState() => _PageTwoScreenState();
}

class _PageTwoScreenState extends State<PageTwoScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  final PageController _pageController = PageController();
  late TabController _tabController;
  int activeIndex = 1;
  late final leftPosition = Tween<double>(
    begin: 200,
    end: 0,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.0,
        0.4,
        curve: Curves.ease,
      ),
    ),
  );

  late final top = Tween<double>(
    begin: 0,
    end: 200,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0,
        0.7,
        curve: Curves.ease,
      ),
    ),
  );

  late final rotate = Tween<double>(
    begin: 0,
    end: -pi / 4,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0,
        1,
        curve: Curves.ease,
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this)
      ..forward();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget? child) {
                return Positioned(
                  top: top.value,
                  left: leftPosition.value,
                  child: Transform.rotate(
                    angle: rotate.value,
                    child: Hero(
                      tag: 'pizza',
                      child: Image.asset(
                        'assets/images/pizza.png',
                        height: 400,
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: top.value,
              left: leftPosition.value,
              child: Transform.rotate(
                angle: rotate.value,
                child: Image.asset(
                  'assets/images/slice.png',
                  height: 400,
                ),
              ),
            ),
            // Positioned(
            //   bottom: 100,
            //   child: Image.asset(
            //     'assets/images/plate.jpg',
            //     height: 400,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
