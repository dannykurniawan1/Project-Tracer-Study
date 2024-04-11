import 'package:flutter/material.dart';


import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// Corrected import path for onboarding_items.dart
import 'package:tracer_study/Onboarding/onboarding_items.dart';


class OnboardingView extends StatefulWidget {
  // Tambahkan konstruktor dengan kunci

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final controller =
      OnboardingItems(); // Tandai sebagai late untuk inisialisasi nanti
  late final PageController
      _pageController; // Tandai sebagai late untuk inisialisasi nanti

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Skip button
                  TextButton(
                      onPressed: () => _pageController
                          .jumpToPage(controller.items.length - 1),
                      child: const Text("Skip")),

                  //indcatorcontroller
                  SmoothPageIndicator(
                      controller: _pageController, // PageController
                      count: 3,
                      effect: WormEffect(
                          dotHeight: 12,
                          dotWidth: 12,
                          activeDotColor:
                              Colors.blue.shade900), // your preferred effect
                      onDotClicked: (index) => _pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 800),
                          curve: Curves.ease)),

                  //Next button
                  TextButton(
                      onPressed: () => _pageController.nextPage(
                          duration: Duration(milliseconds: 800),
                          curve: Curves.ease),
                      child: const Text("Next")),
                ],
              ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: PageView.builder(
          onPageChanged: (index) =>
              setState(() => isLastPage = controller.items.length - 1 == index),
          controller: _pageController,
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(controller.items[index].image),
                const SizedBox(height: 15),
                Text(controller.items[index].title,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 15),
                Text(controller.items[index].descriptions,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ))
              ],
            );
          },
        ),
      ),
    );
  }

  //set started button

  Widget getStarted() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.blue.shade900),
        width: MediaQuery.of(context).size.width * .9,
        height: 55,
        child: TextButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home()));
            },
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white),
            )));
  }
}
