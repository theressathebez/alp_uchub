import 'package:alp_uchub/model/auth_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alp_uchub/viewmodel/auth_viewmodel.dart';
import '../../shared/theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int _currentStep = 0;

  final _nameController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _majorController = TextEditingController();
  final _batchController = TextEditingController();
  final _gpaController = TextEditingController();
  final _wishlistController = TextEditingController();
  final _skillController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    _emailController.dispose();
    _majorController.dispose();
    _batchController.dispose();
    _gpaController.dispose();
    _wishlistController.dispose();
    _skillController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 1) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F1),

      body: Stack(
        children: [
          Positioned(top: -50, right: -50, child: _buildBgCircle(250)),
          Positioned(bottom: 50, left: -80, child: _buildBgCircle(350)),

          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              children: [
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 850),
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 40,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeaderSection(),
                        const SizedBox(height: 30),

                        _buildStepper(),
                        const SizedBox(height: 30),
                        const Divider(color: Color(0xFFF5F5F5), thickness: 2),
                        const SizedBox(height: 30),

                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: _currentStep == 0
                              ? Column(
                                  key: const ValueKey(0),
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Basic Details",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    _buildBasicInfo(),
                                  ],
                                )
                              : Column(
                                  key: const ValueKey(1),
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Career Survey",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    _buildSurveySection(),
                                  ],
                                ),
                        ),

                        const SizedBox(height: 40),

                        // --- ACTION BUTTONS ---
                        _buildActionButtons(),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                _buildSignInRedirect(),
                const SizedBox(height: 50),
              ],
            ),
          ),

          Positioned(
            top: 24,
            left: 16,
            child: SafeArea(child: _buildBackButton(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    return Center(
      child: SizedBox(
        width: 420,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStepItem(
              index: 0,
              label: "Personal Data",
              isActive: _currentStep >= 0,
            ),

            Container(
              width: 200,
              height: 2,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: _currentStep >= 1
                  ? AppColors.primaryOrange
                  : Colors.grey[300],
            ),

            _buildStepItem(
              index: 1,
              label: "Career Survey",
              isActive: _currentStep >= 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem({
    required int index,
    required String label,
    required bool isActive,
  }) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryOrange : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? AppColors.primaryOrange : Colors.grey[300]!,
              width: 2,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.primaryOrange.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              "${index + 1}",
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey[400],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildSignInRedirect() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Already have an account? ",
          style: const TextStyle(color: AppColors.grey, fontSize: 14),
          children: [
            TextSpan(
              text: "Sign In",
              style: const TextStyle(
                color: AppColors.primaryOrange,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBgCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryOrange.withOpacity(0.06),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Join UC HUB",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "Complete the form to start your career journey",
              style: TextStyle(color: AppColors.grey, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  // --- BASIC INFO ---
  Widget _buildBasicInfo() {
    return Column(
      children: [
        _buildTextField("Full Name", _nameController, "Enter your full name"),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _buildTextField("NIM", _nimController, "0106xxxx")),
            const SizedBox(width: 20),
            Expanded(
              child: _buildTextField(
                "Email Student",
                _emailController,
                "@student.ciputra.ac.id",
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                "Major / Jurusan",
                _majorController,
                "e.g. IMT",
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildTextField(
                "Batch / Angkatan",
                _batchController,
                "2021",
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- SURVEY ---
  Widget _buildSurveySection() {
    final vm = Provider.of<AuthViewModel>(context);
    return Column(
      children: [
        _buildTextField("Current GPA (IPK)", _gpaController, "e.g. 3.85"),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Primary Interest",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: vm.selectedInterest,
              decoration: _inputDecoration("Select your primary interest"),
              items: ["Web Dev", "UI/UX", "Marketing", "Data Science"]
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, style: const TextStyle(fontSize: 14)),
                    ),
                  )
                  .toList(),
              onChanged: (val) => vm.setInterest(val),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildSkillSection(vm),
        const SizedBox(height: 20),
        _buildTextField(
          "Company Wishlist",
          _wishlistController,
          "Which company do you want to join?",
        ),
      ],
    );
  }

  Widget _buildSkillSection(AuthViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Skill Utama (Max 5)",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _skillController,
          onSubmitted: (val) {
            if (val.isNotEmpty) {
              vm.addSkill(val);
              _skillController.clear();
            }
          },
          decoration: _inputDecoration("Type a skill and press Enter"),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: vm.skills
              .map(
                (s) => Chip(
                  label: Text(
                    s,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onDeleted: () => vm.removeSkill(s),
                  backgroundColor: AppColors.lightOrange.withOpacity(0.3),
                  deleteIconColor: AppColors.primaryOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide.none,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hint,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 10),
        TextField(controller: controller, decoration: _inputDecoration(hint)),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }

  // --- BUTTONS ---
  Widget _buildActionButtons() {
    if (_currentStep == 0) {
      return SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: _nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 8,
            shadowColor: AppColors.primaryOrange.withOpacity(0.4),
          ),
          child: const Text(
            "Continue",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 55,
              child: OutlinedButton(
                onPressed: _prevStep,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Back",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  final vm = Provider.of<AuthViewModel>(context, listen: false);
                  final data = StudentModel(
                    fullName: _nameController.text,
                    nim: _nimController.text,
                    email: _emailController.text,
                    major: _majorController.text,
                    batch: _batchController.text,
                    interest: vm.selectedInterest ?? "",
                    gpa: double.tryParse(_gpaController.text) ?? 0.0,
                    skills: List.from(vm.skills),
                    companyWishlist: _wishlistController.text,
                  );
                  vm.registerStudent(data);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 8,
                  shadowColor: AppColors.primaryOrange.withOpacity(0.4),
                ),
                child: const Text(
                  "Submit Registration",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}

Widget _buildBackButton(BuildContext context) {
  return InkWell(
    borderRadius: BorderRadius.circular(30),
    onTap: () {
      Navigator.pushReplacementNamed(context, '/welcome');
    },
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 20,
        color: Colors.black87,
      ),
    ),
  );
}
