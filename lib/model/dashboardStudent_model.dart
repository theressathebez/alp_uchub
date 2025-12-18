enum ApplicationStatus { applied, shortlisted, accepted, rejected }

class ApplicationItem {
  final String id;
  final String companyName;
  final String role;
  final String date;
  final ApplicationStatus status;

  ApplicationItem({
    required this.id,
    required this.companyName,
    required this.role,
    required this.date,
    required this.status,
  });
}

class RecommendationItem {
  final String id;
  final String companyName;
  final String role;
  final String matchScore;
  bool isAccepted;

  RecommendationItem({
    required this.id,
    required this.companyName,
    required this.role,
    required this.matchScore,
    this.isAccepted = false,
  });
}