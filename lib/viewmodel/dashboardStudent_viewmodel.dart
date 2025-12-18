import 'package:flutter/material.dart';
import '../model/dashboardStudent_model.dart';

class DashboardStudentViewModel extends ChangeNotifier {
  int _selectedIndex = 2; 
  
  final List<ApplicationItem> _applications = [
    ApplicationItem(
      id: '1',
      companyName: "Tokopedia",
      role: "Software Engineer Intern",
      date: "18 Dec 2025",
      status: ApplicationStatus.accepted,
    ),
    ApplicationItem(
      id: '2',
      companyName: "Gojek",
      role: "UI/UX Designer",
      date: "15 Dec 2025",
      status: ApplicationStatus.shortlisted,
    ),
    ApplicationItem(
      id: '3',
      companyName: "Traveloka",
      role: "Data Analyst",
      date: "10 Dec 2025",
      status: ApplicationStatus.applied,
    ),
    ApplicationItem(
      id: '4',
      companyName: "Shopee",
      role: "Backend Developer",
      date: "01 Dec 2025",
      status: ApplicationStatus.rejected,
    ),
  ];

  final List<RecommendationItem> _recommendations = [
    RecommendationItem(
      id: 'r1',
      companyName: "Bank BCA",
      role: "Mobile Developer",
      matchScore: "95%",
    ),
    RecommendationItem(
      id: 'r2',
      companyName: "Unilever",
      role: "Digital Marketing Intern",
      matchScore: "90%",
    ),
    RecommendationItem(
      id: 'r3',
      companyName: "Grab",
      role: "Product Manager Intern",
      matchScore: "88%",
    ),
  ];

  int get selectedIndex => _selectedIndex;
  List<ApplicationItem> get applications => _applications;
  List<RecommendationItem> get recommendations => _recommendations;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void acceptRecommendation(String id, BuildContext context) {
    final index = _recommendations.indexWhere((item) => item.id == id);
    if (index != -1) {
      _recommendations[index].isAccepted = true;
      
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lowongan diterima. Tim ICE akan segera menghubungi Anda."),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}