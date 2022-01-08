import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations/screens/food/PageTwo.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FoodOnboardingScreen extends StatefulWidget {
  const FoodOnboardingScreen({Key? key}) : super(key: key);

  @override
  _FoodOnboardingScreenState createState() => _FoodOnboardingScreenState();
}

class _FoodOnboardingScreenState extends State<FoodOnboardingScreen>
    with TickerProviderStateMixin {
  Size? size;
  final _scrollController = ScrollController();
  late AnimationController _animationController;
  late AnimationController _animationController2;
  late AnimationController _animationController3;
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
    end: 100,
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

  late Animation<double> sliceleftPosition = Tween<double>(
    begin: -260,
    end: -45,
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

  late Animation<double> sliceTop = Tween<double>(
    begin: -55,
    end: 43,
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

  late Animation<double> sliceleftPosition3 = Tween<double>(
    begin: 260,
    end: 10,
  ).animate(
    CurvedAnimation(
      parent: _animationController3,
      curve: const Interval(
        0.0,
        0.4,
        curve: Curves.ease,
      ),
    ),
  );

  late Animation<double> sliceTop3 = Tween<double>(
    begin: -300,
    end: 10,
  ).animate(
    CurvedAnimation(
      parent: _animationController3,
      curve: const Interval(
        0,
        0.7,
        curve: Curves.ease,
      ),
    ),
  );

  late final rotate3 = Tween<double>(
    begin: 0,
    end: -pi / 3,
  ).animate(
    CurvedAnimation(
      parent: _animationController3,
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
        duration: const Duration(milliseconds: 2000), vsync: this);
    _animationController2 = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    _animationController3 = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    _scrollController.addListener(() {
      if (_scrollController.position.hasPixels) {
        print(_scrollController.position.pixels);
        if (_scrollController.position.pixels == size!.width) {
          _animationController.forward();
          _tabController.animateTo(1);
        } else if (_scrollController.position.pixels > size!.width) {
          _tabController.animateTo(2);
          _animationController2.repeat();
          _animationController3.forward();
        }
      }
    });
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
    setState(() {
      size = MediaQuery.of(context).size;
    });
    return Scaffold(
      body: Container(
        width: size!.width,
        height: size!.height,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: size!.height,
              width: size!.width,
              color: Colors.white,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: PageScrollPhysics(),
                controller: _scrollController,
                // controller: _pageController,
                // onPageChanged: (value) {
                //   _animationController.forward();
                //   _tabController.animateTo(value);
                // },
                children: <Widget>[
                  Container(
                    height: size!.height,
                    width: size!.width,
                    color: Colors.white,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          left: 200,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PageTwoScreen()),
                            ),
                            child: Hero(
                              tag: 'pizza',
                              child: Image.asset(
                                'assets/images/pizza.png',
                                height: 400,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 250,
                          left: -20,
                          child: Image.asset(
                            'assets/images/pasta.png',
                            height: 250,
                          ),
                        ),
                        const Positioned(
                          bottom: 200,
                          child: Text(
                            "Find Your Food",
                            style: TextStyle(
                                fontFamily: "Merriweather-Bold",
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                          bottom: 160,
                          child: Text(
                            "Slide To Start your journey",
                            style: TextStyle(
                              fontFamily: "Merriweather-Light",
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: size!.height,
                    width: size!.width,
                    color: Colors.white,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (BuildContext context, Widget? child) {
                            return Stack(
                              children: [
                                Positioned(
                                  top: top.value,
                                  right: leftPosition.value,
                                  child: Transform.rotate(
                                    angle: rotate.value,
                                    child: Image.asset(
                                      'assets/images/pizza.png',
                                      height: 400,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: sliceTop.value,
                                  left: sliceleftPosition.value,
                                  child: Transform.rotate(
                                    angle: rotate.value,
                                    child: Image.asset(
                                      'assets/images/slice.png',
                                      height: 500,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const Positioned(
                          bottom: 200,
                          child: Text(
                            "Fill your cravings",
                            style: TextStyle(
                                fontFamily: "Merriweather-Bold",
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                          bottom: 160,
                          child: Text(
                            "Customize your food",
                            style: TextStyle(
                              fontFamily: "Merriweather-Light",
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size!.height,
                    width: size!.width,
                    child: AnimatedBuilder(
                      animation: _animationController3,
                      builder: (BuildContext context, Widget? child) {
                        return Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Positioned(
                              bottom: 250,
                              left: -50,
                              child: AnimatedBuilder(
                                  animation: _animationController2,
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Transform.rotate(
                                      angle:
                                          _animationController2.value * 2 * pi,
                                      child: Image.asset(
                                        'assets/images/coffee.png',
                                        height: 250,
                                      ),
                                    );
                                  }),
                            ),
                            Positioned(
                              top: 70,
                              child: Image.asset(
                                'assets/images/plate.png',
                                height: 250,
                              ),
                            ),
                            Positioned(
                              top: sliceTop3.value,
                              right: sliceleftPosition3.value,
                              child: Transform.rotate(
                                angle: rotate3.value,
                                child: Image.asset(
                                  'assets/images/slice.png',
                                  height: 500,
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 200,
                              child: Text(
                                "Order Now",
                                style: TextStyle(
                                    fontFamily: "Merriweather-Bold",
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                              bottom: 160,
                              child: Text(
                                "Click to order",
                                style: TextStyle(
                                  fontFamily: "Merriweather-Light",
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // Container(

                  //   color: Colors.white,
                  //   child: ListView(
                  //     children: [
                  //       Positioned(
                  //         left: 200,
                  //         child: GestureDetector(
                  //           onTap: () => Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => PageTwoScreen()),
                  //           ),
                  //           child: Hero(
                  //             tag: 'pizza',
                  //             child: Image.asset(
                  //               'assets/images/pizza.png',
                  //               height: 400,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Positioned(
                  //         bottom: 300,
                  //         left: 10,
                  //         child: Image.asset(
                  //           'assets/images/pancake.png',
                  //           height: 180,
                  //         ),
                  //       ),
                  //       const Positioned(
                  //         bottom: 200,
                  //         child: Text(
                  //           "Find Your Food",
                  //           style: TextStyle(
                  //               fontFamily: "Merriweather-Bold",
                  //               fontSize: 30,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //       Positioned(
                  //         bottom: 160,
                  //         child: Text(
                  //           "Slide To Start your journey",
                  //           style: TextStyle(
                  //             fontFamily: "Merriweather-Light",
                  //             fontSize: 14,
                  //             color: Colors.black.withOpacity(0.6),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   width: size!.width,
                  //   height: size!.height,
                  //   color: Colors.white,
                  //   child: Stack(
                  //     alignment: Alignment.topCenter,
                  //     children: [
                  //       AnimatedBuilder(
                  //         animation: _animationController,
                  //         builder: (BuildContext context, Widget? child) {
                  //           return Positioned(
                  //             top: top.value,
                  //             left: leftPosition.value,
                  //             child: Transform.rotate(
                  //               angle: rotate.value,
                  //               child: Image.asset(
                  //                 'assets/images/pizza.png',
                  //                 height: 400,
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Positioned(
              bottom: 100,
              child: TabPageSelector(
                color: Colors.grey.withOpacity(0.1),
                selectedColor: Colors.black,
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
