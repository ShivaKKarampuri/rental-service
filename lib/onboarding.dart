import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:provider/provider.dart';
import 'package:rent_app/login.dart';
import 'package:rent_app/searchpage.dart';
import 'package:rent_app/utils/preferences.dart';

void main() {
  runApp(OnboardingApp());
}

class OnboardingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      home: OnboardScreen(),
    );
  }
}

class OnboardScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider<OnBoardState>(
      create: (_) => OnBoardState(),
      child: Scaffold(
        body: OnBoard(
          pageController: _pageController,
          onSkip: () {
            goToLoginPage(context);

            },
          onDone: () {
            goToLoginPage(context);
          },
          onBoardData: onBoardData,
          titleStyles: const TextStyle(
            color: Colors.deepOrange,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.15,
          ),
          descriptionStyles: TextStyle(
            fontSize: 16,
            color: Colors.brown.shade300,
          ),
          pageIndicatorStyle: const PageIndicatorStyle(
            width: 100,
            inactiveColor: Colors.deepOrangeAccent,
            activeColor: Colors.deepOrange,
            inactiveSize: Size(8, 8),
            activeSize: Size(12, 12),
          ),
          skipButton: TextButton(
            onPressed: () {
              goToLoginPage(context);
            },
            child: const Text(
              "Skip",
              style: TextStyle(color: Colors.deepOrangeAccent),
            ),
          ),
          nextButton: Consumer<OnBoardState>(
            builder: (BuildContext? context, OnBoardState? state, Widget? child) {
              return InkWell(
                onTap: () => _onNextTap(state!, context!),
                child: Container(
                  width: 230,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Colors.redAccent, Colors.deepOrangeAccent],
                    ),
                  ),
                  child: Text(
                    state!.isLastPage ? "Get Started" : "Next",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState, BuildContext context) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      goToLoginPage(context);
    }
  }

  void goToLoginPage(BuildContext context) {

    Preference.setBool("onBoard", true);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder:
            (context) => LoginPage()
        )
    );
  }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Set your own goals and get better",
    description: "Goal support your motivation and inspire you to work harder",
    imgUrl: "assets/onboard1.png",
  ),
  const OnBoardModel(
    title: "Track your progress with statistics",
    description:
    "Analyse personal result with detailed chart and numerical values",
    imgUrl: 'assets/onboard2.png',
  ),
  const OnBoardModel(
    title: "Create photo comparissions and share your results",
    description:
    "Take before and after photos to visualize progress and get the shape that you dream about",
    imgUrl: 'assets/onboard1.png',
  ),
];