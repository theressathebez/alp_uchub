class StudentModel {
  final String fullName;
  final String nim;
  final String email;
  final String major;
  final String batch;
  final String interest;
  final double gpa;
  final List<String> skills;
  final String companyWishlist;

  StudentModel({
    required this.fullName,
    required this.nim,
    required this.email,
    required this.major,
    required this.batch,
    required this.interest,
    required this.gpa,
    required this.skills,
    required this.companyWishlist,
  });
}
