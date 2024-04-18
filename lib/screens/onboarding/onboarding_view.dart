import 'package:watchdog/screens/onboarding/onboarding_info.dart';


class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
      title: "Piga ripoti", 
      description: "Report crimes or accidents using your mobile device or computer.", 
      image: "assets/onboarding/report-crime.gif",
    ),
    OnboardingInfo(
      title: "Sheria mkononi", 
      description: "Help law enforcement agents to maintain law and order by reporting crimes or reporting wanted suspects.", 
      image: "assets/onboarding/law.gif",
    ),
    OnboardingInfo(
      title: "Okoa maisha", 
      description: "Help road accident victims get faster medical attention by reporting fatal road accidents in your current location.", 
      image: "assets/onboarding/medical-attention.gif",
    ),
    OnboardingInfo(
      title: "Uhondo kamili", 
      description: "Get updates about the latest reported incidents on your news feed.", 
      image: "assets/onboarding/news-feed.gif",
    ),
    OnboardingInfo(
      title: "Kaa chonjo kwa streets",
      description: "Plan your routes or visitation in advance by viewing incidents reported in your current location on a map.",
      image: "assets/onboarding/location.gif",
    ),
  ];
}