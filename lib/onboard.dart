import 'package:crypto_tracker/views/auth/intro_auth.dart';
import 'package:crypto_tracker/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoard(
        pageController: _pageController,
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        onSkip: () {
          print('skipped');
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        // Either Provide onDone Callback or nextButton Widget to handle done state
        onDone: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        skipButton: TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => IntroScreen()));
          },
          child: const Text(
            "Skip",
            style: TextStyle(color: Colors.deepOrangeAccent),
          ),
        ),
        // Either Provide onDone Callback or nextButton Widget to handle done state
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return InkWell(
              onTap: () => _onNextTap(state),
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
                child: state.isLastPage
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const IntroScreen()));
                        },
                        child: const Text(
                          "Done",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : const Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      //print("nextButton pressed");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const IntroScreen()));
    }
  }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "The best crypto wallet you can trust",
    description: "We support your motivation and inspire you trade wisely",
    imgUrl: "assets/images/wallet.png",
  ),
  const OnBoardModel(
    title: "How to Deposit",
    description:
        "Kindly copy the wallet address on your scrren and insert your deposit amount, in few minutes, Crappo credits you",
    imgUrl: 'assets/images/deposit.png',
  ),
  const OnBoardModel(
    title: "Initiate a withdrawal request",
    description:
        "Once a withdrawal request is initiated Crappo credits you in minutes without delays",
    imgUrl: 'assets/images/withdraw.png',
  ),
];
