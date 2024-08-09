import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:your_friend/GeminiScreen/GeminiScreen.dart';

import '../IntroScreens/HomeScreenA.dart';
import '../IntroScreens/HomeScreenB.dart';
import '../IntroScreens/HomeScreenC.dart';

class AdPage extends StatefulWidget {
  const AdPage({super.key});

  @override
  State<AdPage> createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {
  PageController pageController = PageController();

  String buttonText = "Skip";
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentPageIndex = index;
                buttonText = (index == 2) ? "Finish" : "Skip";
              });
            },
            children: const [
              HomeScreenA(),
              HomeScreenB(),
              HomeScreenC(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    if (currentPageIndex == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Geminiscreen()),
                      );
                    } else {
                      pageController.jumpToPage(2);
                    }
                  },
                  child: Text(buttonText),
                ),
                const SizedBox(),
                SmoothPageIndicator(controller: pageController, count: 3),
                currentPageIndex == 2
                    ? const SizedBox(width: 10)
                    : GestureDetector(
                        onTap: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text("Next"),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
