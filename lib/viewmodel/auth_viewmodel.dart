import 'package:alp_uchub/model/auth_model.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  // State untuk Registrasi
  String? _selectedInterest;
  final List<String> _skills = [];

  String? get selectedInterest => _selectedInterest;
  List<String> get skills => _skills;

  // Logika Login & Role Detection
  void login(String email, String password, BuildContext context) {
    if (email.isEmpty || password.isEmpty) {
      _showSnackBar(context, "Email dan Password tidak boleh kosong");
      return;
    }

    // Role Detection Logic
    if (email.contains('admin')) {
      print("Navigating to Admin Dashboard...");
      // Navigator.pushReplacementNamed(context, '/admin');
    } else if (email.contains('@student.ciputra.ac.id')) {
      print("Navigating to Student Dashboard...");
      // Navigator.pushReplacementNamed(context, '/student');
    } else {
      _showSnackBar(context, "Email tidak dikenali sebagai Student atau Admin");
    }
  }

  // Logika Manajemen Skill Tags
  void addSkill(String skill) {
    if (skill.isNotEmpty && _skills.length < 5) {
      _skills.add(skill);
      notifyListeners();
    }
  }

  void removeSkill(String skill) {
    _skills.remove(skill);
    notifyListeners();
  }

  void setInterest(String? value) {
    _selectedInterest = value;
    notifyListeners();
  }

  // Logika Simpan Registrasi
  void registerStudent(StudentModel student) {
    print("Saving student: ${student.fullName}");
    // Panggil API di sini
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
