import 'package:flutter/material.dart';
import '../model/landing_content_model.dart';

class WelcomeViewModel extends ChangeNotifier {
  final List<StatItemModel> _stats = [
    StatItemModel(number: "1000+", label: "Active Students"),
    StatItemModel(number: "40+", label: "Partner Companies"),
    StatItemModel(number: "50+", label: "Available Jobs"),
  ];

  final List<FeatureItemModel> _features = [
    FeatureItemModel(
      icon: Icons.person_search_rounded,
      title: "Smart Recommendation",
      description:
          "Get personalized job recommendations based on your skills and interests.",
    ),
    FeatureItemModel(
      icon: Icons.file_present_rounded,
      title: "Auto-Generate Documents",
      description:
          "Automatically generate professional cover letters and internship proposals in one click.",
    ),
    FeatureItemModel(
      icon: Icons.domain_rounded,
      title: "Company Wishlist",
      description:
          "Let ICE know your dream companies so we can explore future partnerships.",
    ),
  ];

  List<StatItemModel> get stats => _stats;
  List<FeatureItemModel> get features => _features;

  void navigateToLogin(BuildContext context) {
    debugPrint("Navigasi ke Login Page");
    // Navigator.pushNamed(context, '/login');
  }

  void navigateToFindJobs(BuildContext context) {
    debugPrint("Navigasi ke Find Jobs");
  }

  void navigateToPartners(BuildContext context) {
    debugPrint("Navigasi ke Partners");
  }
}
