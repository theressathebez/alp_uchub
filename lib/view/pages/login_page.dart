import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alp_uchub/viewmodel/auth_viewmodel.dart';
import '../../shared/theme.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F1), // Background Peach konsisten
      body: Stack(
        children: [
          Row(
            children: [
              if (MediaQuery.of(context).size.width > 900)
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _Bubble(
                        size: 380,
                        offset: const Offset(30, 120),
                        colors: [
                          AppColors.primaryOrange.withOpacity(0.2),
                          const Color(0xFFFFB74D).withOpacity(0.1),
                        ],
                      ),

                      _Bubble(
                        size: 180,
                        offset: const Offset(400, 460),
                        colors: [
                          const Color(0xFFFFB74D).withOpacity(0.35),
                          AppColors.primaryOrange.withOpacity(0.15),
                        ],
                      ),

                      Positioned(
                        bottom: -10,
                        left: 50,
                        child: Image.asset(
                          'assets/images/orang.png',
                          width: 600,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),

              Expanded(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    margin: const EdgeInsets.all(40),
                    padding: const EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Login to access your UC HUB account",
                          style: TextStyle(color: AppColors.grey, fontSize: 15),
                        ),
                        const SizedBox(height: 40),

                        _buildInputField(
                          "Email Address",
                          _emailController,
                          "Enter your email",
                          false,
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          "Password",
                          _passwordController,
                          "Enter your password",
                          true,
                        ),

                        const SizedBox(height: 40),
                        _buildLoginButton(viewModel, context),
                        const SizedBox(height: 24),
                        _buildFooter(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 24,
            left: 24,
            child: SafeArea(child: _buildBackButton(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    String hint,
    bool obscure,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton(AuthViewModel vm, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: () =>
            vm.login(_emailController.text, _passwordController.text, context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryOrange,
          elevation: 8,
          shadowColor: AppColors.primaryOrange.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
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

  Widget _buildFooter(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Don't have an account? ",
            style: TextStyle(color: AppColors.grey),
          ),
          GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, '/register'),
            child: const Text(
              "Sign Up",
              style: TextStyle(
                color: AppColors.primaryOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final double size;
  final Offset offset;
  final List<Color> colors;

  const _Bubble({
    required this.size,
    required this.offset,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
