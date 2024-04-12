import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:watchdog/pages/login.dart';
import 'package:watchdog/screens/onboarding/onboarding_view.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = OnboardingItems();
  final pageController = PageController();
  bool isLastPage = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: isLastPage ? getStarted() : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Skip button
              TextButton(
                onPressed: () {
                  pageController.jumpToPage(controller.items.length - 1);
                }, 
                child: const Text('Skip'),
              ),
              SmoothPageIndicator(
                controller: pageController,
                count: controller.items.length,
                effect: WormEffect(
                  activeDotColor: Colors.blue.shade900,
                ),
                onDotClicked: (index) {
                  pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 600), 
                    curve: Curves.easeIn
                  );
                },
              ),
              // Next button
              TextButton(
                onPressed: () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 600), 
                    curve: Curves.easeIn,
                  );
                }, 
                child: const Text('Next'),
              ),
            ],
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          child: PageView.builder(
            onPageChanged: (index) => setState(() => isLastPage = controller.items.length -1 == index) ,
            controller: pageController,
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[index].image, height: 350.0, fit: BoxFit.contain),
                  const SizedBox(height: 5.0),
                  Text(
                    controller.items[index].title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Text(
                    controller.items[index].description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
    );
  }

  // Get started button
  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.blue.shade900,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      child: TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
        }, 
        child: const Text(
          'Get started',
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ),
    );
  }
}